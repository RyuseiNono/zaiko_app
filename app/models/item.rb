class Item < ApplicationRecord
  belongs_to :shop
  with_options presence: true do
    validates :name,:count
  end
end
