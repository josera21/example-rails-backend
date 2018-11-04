require 'test_helper'

class UsuarioTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "debe crear un usuario" do 
  	u = Usuario.new(username: "jose", email: "jose@correo.com", password: "123456")
  	assert u.save
  end
  test "debe crear un usuario sin indicar email" do
  	u = Usuario.new(username: "jose", password: "123456")
  	assert u.save
  end
end
