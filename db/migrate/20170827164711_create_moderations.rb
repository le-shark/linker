class CreateModerations < ActiveRecord::Migration[5.1]
  def change
    create_table :moderations do |t|
      t.integer :moderator_id
      t.integer :moderated_id
    end
    add_index :moderations, :moderator_id
    add_index :moderations, :moderated_id
    add_index :moderations, [:moderated_id, :moderated_id], unique: true
  end
end
