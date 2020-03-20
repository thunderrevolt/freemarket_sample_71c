class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name,           null: false
      t.string :description,    null: false
      t.string :category,       null: false
      t.string :brand
      t.string :status,         null: false
      t.string :postage_bearer, null: false
      t.string :shipping_area,  null: false
      t.string :shipping_day,   null: false
      t.string :price,          null: false
      t.string :size
      t.references :category,   foreign_key: true
      t.references :user,       foreign_key: true
      t.timestamps
    end
  end

  validates :images, presence: true, length: {manimum: 1, maximum: 10}
  validates :name, presence: true, length: { maximum: 40 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :price, presence: true, inclusion: 300..9999999

end
