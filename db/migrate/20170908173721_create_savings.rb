class CreateSavings < ActiveRecord::Migration[5.1]
  def change
    create_table :savings do |t|
      t.integer :saver_id
      t.integer :saved_id
    end
    add_index :savings, :saver_id
    add_index :savings, :saved_id
    add_index :savings, [:saved_id, :saver_id], unique: true
  end
end
