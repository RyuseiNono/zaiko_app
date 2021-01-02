class Shop < ApplicationRecord
  belongs_to :admin
  has_one_attached :image, dependent: :destroy
  has_many :items

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

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :presence
  belongs_to :usability

end
