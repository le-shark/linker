class RemoveIndicesFromSavings < ActiveRecord::Migration[5.1]
  def change
    remove_index "saver_id", name: "index_savings_on_saved_id_and_saver_id"
  end
end
