class Transaction < ApplicationRecord
  belongs_to :usuario
  validates :token, presence: true
  validates :payerid, presence: true
  validates :ip_address, presence: true

  def pagar?
  	response = procesar_compra
  	self.respuesta = response.message
  	self.save

  	if response.success?
  		self.usuario.payments.each do |payment|
  			payment.update(estado: 2)
  		end
  		true
  	else
  		false
  	end
  end

  private

  def procesar_compra
  	EXPRESS_GATEWAY.purchase(self.usuario.costo_compra_pendiente * 100, opciones_compra)
  end

  def opciones_compra
  	{
  		ip: self.ip_address,
  		token: self.token,
  		payer_id: self.payerid
  	}
  end
end
