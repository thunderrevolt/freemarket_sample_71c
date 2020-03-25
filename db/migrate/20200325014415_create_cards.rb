class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.integer :number,  null: false
      t.integer :month,   null: false
      t.integer :year,    null: false
      t.integer :pass,    null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
