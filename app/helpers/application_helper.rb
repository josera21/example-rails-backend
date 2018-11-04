module ApplicationHelper
	def get_email_auth
		if session[:omniauth_data]
			session[:omniauth_data][:email]
		else
			""
		end
	end

	def get_username_auth
		if session[:omniauth_data]
			session[:omniauth_data][:username]
		else
			""
		end
	end
end
