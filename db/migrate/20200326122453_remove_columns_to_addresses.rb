class RemoveColumnsToAddresses < ActiveRecord::Migration[5.2]
  def change
    remove_column :addresses, :zipcode, :integer
    remove_column :addresses, :number, :integer
    remove_column :addresses, :tel, :integer
  end
end
