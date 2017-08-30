class MakeTypeNotNull < ActiveRecord::Migration[5.1]
  def change
    change_column :posts, :type, :string, :null => false
  end
end
