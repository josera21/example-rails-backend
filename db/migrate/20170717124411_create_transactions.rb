class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.string :token
      t.string :payerid
      t.references :usuario, foreign_key: true
      t.decimal :total, precision: 10, scale: 3
      t.string :respuesta

      t.timestamps
    end
  end
end
