class AddPriceToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :price, :integer, limit: 6
  end
end
