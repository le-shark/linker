class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :type
      t.string :title
      t.string :link
      t.text :text
      t.integer :user_id
      t.integer :community_id

      t.timestamps
    end
    add_index :posts, :user_id
  end
end
