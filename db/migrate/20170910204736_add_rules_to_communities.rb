class AddRulesToCommunities < ActiveRecord::Migration[5.1]
  def change
    add_column :communities, :rules, :string
  end
end
