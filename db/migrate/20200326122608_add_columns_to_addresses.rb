class AddColumnsToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :tel, :integer, limit: 6
    add_column :addresses, :street_address, :string, null: false
  end
end
