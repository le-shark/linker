class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :text
      t.integer :commentable_id
      t.string :commentable_type
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
