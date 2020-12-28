class Shop < ApplicationRecord
  belongs_to :admin
  has_one_attached :image, dependent: :destroy

  with_options presence: true do
    validates :name,:location
    validates :phone_number,     format: { with: /\A[\d]{1,}\z/ }
    # prefecture_id
    # opening_time
    # closing_time
    # parking_id
    # credit_card_id
    # electronic_money_id
  end

end
