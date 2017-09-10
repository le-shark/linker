class AddGoldToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :gold, :integer, default: 0
  end
end
