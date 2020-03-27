class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :tel, :integer, limit: 6, null: false
    add_column :users, :birthday, :date, null: false
  end
end
