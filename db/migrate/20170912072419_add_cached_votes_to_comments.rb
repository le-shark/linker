class AddCachedVotesToComments < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :cached_votes_total, :integer, default: 0
    add_index  :comments, :cached_votes_total
  end
end
