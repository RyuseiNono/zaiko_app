class Item < ApplicationRecord
  belongs_to :shop
  with_options presence: true do
    validates :name
    validates :price, numericality: { only_integer: true }, length: { maximum: 8 }
    validates :count, numericality: { only_integer: true }, length: { maximum: 2 }
  end
end
