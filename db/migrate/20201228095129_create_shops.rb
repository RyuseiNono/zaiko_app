class CreateShops < ActiveRecord::Migration[6.0]
  def change
    create_table :shops do |t|
      t.string :name,                    null: false
      t.integer :prefecture_id,          null: false
      t.text :location,                  null: false
      t.string :phone_number,            null: false
      t.time :opening_time,              null: false
      t.time :closing_time,              null: false
      t.integer :parking_id,             null: false
      t.integer :credit_card_id,         null: false
      t.integer :electronic_money_id,    null: false
      t.references :admin,               null: false, foreign_key: true
      t.timestamps
    end
  end
end
