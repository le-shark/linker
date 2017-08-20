class ChangeAboutMeTypeForUsers < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :about_me, :text
  end
end
