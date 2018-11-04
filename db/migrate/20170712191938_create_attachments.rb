class CreateAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :attachments do |t|
      t.string :nombre
      t.string :extension
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
