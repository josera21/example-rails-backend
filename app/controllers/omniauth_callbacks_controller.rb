class OmniauthCallbacksController < ApplicationController
	def facebook
		# Esta variable es la que se trae la informacion para iniciar
		auth = request.env["omniauth.auth"]
		# raise auth.to_yaml Usado para ver los datos que traia el Hash
		data = {
			name: auth.info.name,
			last_name: auth.info.last_name,
			username: auth.info.nickname,
			email: auth.info.email,
			provider: auth.provider,
			uid: auth.uid
		}

		usuario = Usuario.find_or_create_by_omniauth(data)
		# El metodo persisted devuelve true si el registro se guardo en la BD
		if usuario.persisted?
			sign_in_and_redirect usuario, event: :authentication
		else
			# El metodo .to_sentence hace que los errores se traduzcan a un lenguaje amigable para los
			# Usuarios, como "ese correo ya esta en uso"
			session[:omniauth_errors] = usuario.errors.full_messages.to_sentence unless usuario.save

			session[:omniauth_data] = data
			# Si no pudimos registrar al usuario, lo redirijimos al formulario de registro
			redirect_to new_usuario_registration_url
		end
	end

	def twitter
		auth = request.env["omniauth.auth"]
		
		data = {
			name: auth.info.name,
			last_name: "",
			username: auth.info.nickname,
			email: "", # Twitter no devuelve email
			provider: auth.provider,
			uid: auth.uid
		}

		usuario = Usuario.find_or_create_by_omniauth(data)
		if usuario.persisted?
			sign_in_and_redirect usuario, event: :authentication
		else
			session[:omniauth_errors] = usuario.errors.full_messages.to_sentence unless usuario.save
			session[:omniauth_data] = data

			redirect_to new_usuario_registration_url
		end
	end
end