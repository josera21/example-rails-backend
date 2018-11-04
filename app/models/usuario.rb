class Usuario < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :trackable, :validatable
	devise :omniauthable, omniauth_providers: [:facebook, :twitter]
	
	has_many :posts
	has_many :friendships

	# Si no le coloco el source, rails va a tratar de buscar un follow_id en la tabla friendships
	has_many :follows, through: :friendships, source: :friend # asi buscara friend_id

	# rails trataria de buscar una tabla followers_friendships, por eso le digo que busque Friendships
	# ver video 27 del curso de backend para aclarar mas las cosas
	has_many :followers_friendships, class_name: "Friendship", foreign_key: "friend_id"

	has_many :followers, through: :followers_friendships, source: :usuario

	has_many :payments

	has_many :transactions

	def follow!(amigo_id)
		# Este metodo es para cuando queremos seguir a un amigo.
		# en ruby, se coloca ! en un metodo como convencion cuando queremos cambiar algo
		friendships.create!(friend_id: amigo_id)
	end

	def can_follow?(amigo_id)
		# verifico que no me pueda seguir a mi mismo o que ya este siguiendo a ese amigo.
		not amigo_id == self.id || friendships.where(friend_id: amigo_id).size > 0
	end

	def email_required?
		# Aqui le decimos a devise que no necesita obligatoriamente el correo para crear cuentas
		false
	end

	def costo_compra_pendiente
		# Buscamos los pagos con estado 1, es decir pendientes, luego hacemos una relacion entre el id
		# de la tabla post, con la clave foranea post_id de payments, para traerme el costo y sumarlo
		payments.where(estado: 1).joins("INNER JOIN posts on posts.id == payments.post_id").sum("costo")
		# al hacer payments.where es como decir self.payments o current_usuario.payments
	end

	# Validaciones
	validates :username, presence: true, uniqueness: true, 
	length: {in:5..20, too_short: "Al menos 5 caracteres", too_long: "Maximo 20 caracteres"}

	def self.find_or_create_by_omniauth(auth)
		# Metodo para buscar usuarios que ya hayan iniciado sesion con facebook.
		# si no lo encuentra lo crea.
		usuario = self.find_or_create_by(provider: auth[:provider], uid: auth[:uid]) do |user|
			user.nombre = auth[:name]
			user.apellido = auth[:last_name]
			user.username = auth[:username]
			user.email = auth[:email]
			user.uid = auth[:uid]
			user.provider = auth[:provider]
			user.password = Devise.friendly_token[0,20]
		end
	end

	# Tip para trabajar con hash
	# Hash#slice is a cool ActiveSupport method that lets you copy a hash but only with the
	# desired keys - without manually copying it:
	# hash = { a: 1, b: 2, c: 3}
	# { a: hash[:a], c: hash[:c] } # wow, much typing, such boring
	# hash.slice(:a,:c)
	# result
	# => { a: 1, c: 3}
end
