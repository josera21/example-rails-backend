class AddColumnToPost < ActiveRecord::Migration[5.1]
  def change
  	# con precision indicamos cuantos numeros soportara, 
  	# luego con scale cuantos digitos despues de la coma
    add_column :posts, :costo, :decimal, precision: 10, scale: 3
  end
end
