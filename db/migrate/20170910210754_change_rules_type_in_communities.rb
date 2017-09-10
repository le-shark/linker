class ChangeRulesTypeInCommunities < ActiveRecord::Migration[5.1]
  def change
    change_column :communities, :rules, :text
  end
end
