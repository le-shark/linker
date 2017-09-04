class AddPostKarmaToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :post_karma, :integer, default: 0
  end
end
