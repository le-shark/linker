class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.integer :user_id
      t.integer :community_id

      t.timestamps
    end
    add_index :subscriptions, :user_id
    add_index :subscriptions, :community_id
    add_index :subscriptions, [:user_id, :community_id], unique: true
  end
end
