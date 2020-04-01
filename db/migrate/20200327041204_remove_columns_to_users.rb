class RemoveColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :tel, :integer
    remove_column :users, :birthday, :integer
  end
end