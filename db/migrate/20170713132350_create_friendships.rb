class CreateFriendships < ActiveRecord::Migration[5.1]
  def change
    create_table :friendships do |t|
      t.references :usuario, foreign_key: true
      t.references :friend, foreign_key: false

      t.timestamps
    end
  end
end
