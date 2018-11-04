class UsuarioController < ApplicationController
	skip_before_action :verify_authenticity_token

	def show
		# buscamos al usuario pasandole el parametro id de la URL que viene siendo (usuario/4)
		 @usuario = Usuario.find(params[:id])
	end

	def follow
		respond_to do |format|
			# Tuve que pasar el Id directamente de la vista para probar.
			if current_usuario.follow!(post_params[:friend_id])
				format.json {head :no_content} # lo envio vacio
			else
				format.json {render json: "Se encontraron errores"}
			end
		end
	end

	private
	def post_params
		# params es un objeto que recoge todos los parametros que se le envien ya sea por GET o POST
		# Aca lo que haces es decirle que solo permita que le enviemos el id del amigo
		params.require(:usuario).permit(:friend_id)
	end
end