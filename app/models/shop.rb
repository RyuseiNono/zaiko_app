class Shop < ApplicationRecord
  belongs_to :admin
  has_one_attached :image, dependent: :destroy
end
