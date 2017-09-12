class AddBumpedAtToCommunities < ActiveRecord::Migration[5.1]
  def change
    add_column :communities, :bumped_at, :datetime
  end
end
