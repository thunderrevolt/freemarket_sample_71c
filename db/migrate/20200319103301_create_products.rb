class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.string :category, null: false
      t.string :brand
      t.string :status, null: false
      t.string :postage_bearer, null: false
      t.string :shipping_area, null: false
      t.string :shipping_day, null: false
      t.string :price, null: false
      t.string :size
      t.integer :user_id, null: false, foreign_key: true
      t.integer :category_id, null: false, foreign_key: true
      t.timestamps
    end
  end
end
