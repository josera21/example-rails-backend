class Payment < ApplicationRecord
  belongs_to :post
  belongs_to :usuario
  before_save :valores_por_default
  # Estas validaciones creo que Rails 5 ya valida la presencia de las claves foraneas
  validates :post_id, presence: true
  validates :usuario_id, presence: true

  private
  def valores_por_default
  	# 1 significa que el usuario agrego el producto (el post) al carro pero aun no lo ha pagado.
  	# 2 siginifca que el usuario ya pago el producto (el post)
  	self.estado ||= 1
  end
end
