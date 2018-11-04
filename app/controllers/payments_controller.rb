class PaymentsController < ApplicationController
	before_action :authenticate_usuario!

	def create
		@payment = current_usuario.payments.new(post_params)
		respond_to do |format|
			if @payment.save
				format.html { redirect_to carrito_path }
				format.json {head :no_content}
			else
				redirect_to Post.find(post_params[:post_id]), error: "No hemos podido procesar la compra"
				format.json {head :no_content}
			end
		end
	end

	def carrito
		@payments = current_usuario.payments.where(estado: 1)
	end

	def compras
		@payments = current_usuario.payments.where(estado: 2)
	end

	def express
		costo = current_usuario.costo_compra_pendiente
		# El EXPRESS_GATEWAY se encuentra en config/enviroments/develoments
		# Se multiplica por 100, por que el setup_purchase espera que el pago llegue en centavos
		response = EXPRESS_GATEWAY.setup_purchase(costo * 100,
			ip: request.remote_ip,
			return_url: "http://localhost:3000/transactions/checkout",
			cancel_return_url: "http://localhost:3000/carrito",
			name: "Chekout de compras en EasyDesign",
			amount: costo*100
		)
		# Colocamos el review en false, para que pueda mostrarse el amount cuando el usuario 
		# vaya a confirmar el pago
		redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token, review: false)
	end

	private
	def post_params
		params.require(:payment).permit(:post_id)
	end
end
