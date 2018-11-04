class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.references :post, foreign_key: true
      t.references :usuario, foreign_key: true
      t.integer :estado

      t.timestamps
    end
  end
end
