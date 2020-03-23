class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :first_name,     null: false
      t.string :last_name,      null: false
      t.string :first_name,     null: false
      t.string :last_name_kana, null: false
      t.integer :postal_code,    null: false
      t.string :state,          null: false
      t.string :city,           null: false
      t.integer :number,         null: false
      t.string :apartment
      t.integer :tel
      t.reference :user,        foreign_hey: true
      t.timestamps
    end
  end
end
