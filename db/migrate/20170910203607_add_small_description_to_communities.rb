class AddSmallDescriptionToCommunities < ActiveRecord::Migration[5.1]
  def change
    add_column :communities, :small_description, :string
  end
end
