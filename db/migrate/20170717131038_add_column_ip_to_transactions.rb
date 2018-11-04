class AddColumnIpToTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :ip_address, :string
  end
end
