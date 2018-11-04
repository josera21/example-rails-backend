require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "Debe poder crear un post" do
  	post = Post.create(titulo: "Mi titulo", contenido: "Contenido del post")
  	assert_not post.save
  end
  test "Debe poder actualizar" do 
  	post = posts(:primer_articulo)
  	assert_not post.update(titulo: "Nuevo titulo", contenido: "Otro contenido")
  end
  test "Debe encontrar un post por su id" do
  	post_id = posts(:primer_articulo).id
  	post = Post.find(post_id)
  	assert_equal post, posts(:primer_articulo), "No encontro el registro"
  end
  test "Debe borrar un post" do
  	post = posts(:primer_articulo)
  	post.destroy
  	assert_raise()
  end
  test "no debe crear un post sin titulo" do 
  	post = Post.new
  	assert_not post.save, "El post deberia ser invalido"
  end
  test "cada titulo debe ser unico" do 
  	post = Post.new
  	post.titulo = posts(:primer_articulo).titulo
  	assert post.invalid?, "Dos post no pueden tener el mismo titulo"
  end
end
