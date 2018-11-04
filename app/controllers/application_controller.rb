class ApplicationController < ActionController::Base
  	# Tuve que desactivar la proteccion de Rails 5 en peticiones POST, esta proteccion es llamada CSRF
  	# protect_from_forgery with: :exception
  	# necesario incluirlo en el controlador padre, para luego poder indicar que registro guardar
  	include PublicActivity::StoreController
  	protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format.json? }
end
