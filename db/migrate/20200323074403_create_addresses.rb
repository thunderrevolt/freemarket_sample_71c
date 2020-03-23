class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :first_name,       null: false
      t.string :last_name,        null: false
      t.string :first_name_kana,  null: false
      t.string :last_name_kana,   null: false
      t.integer :zipcode
      t.integer :number,          null: false
      t.string :apartment
      t.integer :tel
      t.reference :user,          foreign_key: true
      t.timestamps
    end
  end
end
