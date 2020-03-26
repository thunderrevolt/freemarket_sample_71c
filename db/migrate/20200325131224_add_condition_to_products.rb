class AddConditionToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :condition, :integer
  end
end
