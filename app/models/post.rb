class Post < ApplicationRecord
  belongs_to :usuario, dependent: :destroy # Si se borra un usuario, se borraran sus posts
  has_many :attachments
  has_many :payments
  validates :titulo, presence: true, uniqueness: true
  before_save :valores_por_default
  # Para mas informacion sobre el metodo message, ver video extra por el min 35-36
  after_create {|post| post.message 'create'}

  # Llamo al concern para que haga la logica de guardar la imagen.
  include Picturable
  include PublicActivity::Model
  # Cada vez que alguien cree un post, lo actualice o lo borre. Se va a guardar en la tabla activitys
  # un registro a esa nueva actividad
  tracked owner: Proc.new{ |controller, model| controller.current_usuario }

  def valores_por_default
  	# al interponer el || le estoy diciendo rails que asigne 0 al costo, solo cuando el 
  	# usuario no lo especifique
  	self.costo ||= 0
  end

  def usuario_ha_pagado? usuario_id
    self.payments.where(estado: 2).size > 0
  end

  def message action
    msg = {
      resource: 'posts',
      action: action,
      id: self.id,
      obj: self,
      username: self.usuario.username.capitalize,
      user_id: self.usuario.id
    }

    $redis.publish 'rt-change', msg.to_json
  end
end
