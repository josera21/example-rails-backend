class ChangeColumnEmailInUsuarios < ActiveRecord::Migration[5.1]
  def change
  	remove_index :usuarios, :email
  end
end
