class AddZip1ToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :zip1, :integer, null: false
    add_column :addresses, :zip2, :integer, null: false
    add_column :addresses, :address1, :string, null: false
    add_column :addresses, :address2, :string, null: false
  end
end
