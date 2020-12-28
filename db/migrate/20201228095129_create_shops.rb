class CreateShops < ActiveRecord::Migration[6.0]
  def change
    create_table :shops do |t|
      t.string :name,                    null: false
      t.text :location,                  null: false
      t.string :phone_number,            null: false
      t.integer :prefecture_id
      t.time :opening_time
      t.time :closing_time
      t.integer :parking_id
      t.integer :credit_card_id
      t.integer :electronic_money_id
      t.references :admin,               null: false, foreign_key: true
      t.timestamps
    end
  end
end
