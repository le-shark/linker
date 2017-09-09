class RemakeSaving < ActiveRecord::Migration[5.1]
  def change
    remove_column :savings, :saved_id, :integer
    add_column :savings, :saved_type, :string
    add_column :savings, :saved_post_id, :integer
    add_column :savings, :saved_comment_id, :integer
  end
end
