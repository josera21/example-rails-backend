class RegistrationsController < Devise::RegistrationsController
	def new
		# super para que el controlador siga haciendo lo que haria el controlador padre
		super
	end

	def create
		super
	end

	def update
		super
	end

	private
	def sign_up_params
		# Para asignar los parametros de username, ya que devise no lo permitia
		allow = [:email, :username, :password, :password_confirmation]
		params.require(resource_name).permit(allow)
	end
end