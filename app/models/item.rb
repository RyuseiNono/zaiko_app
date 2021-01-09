class Item < ApplicationRecord
  belongs_to :shop
  with_options presence: true do
    validates :name
    validates :count
    validates :price, numericality: {}, length: { maximum: 8 }
    validates :shop_id
  end
end
