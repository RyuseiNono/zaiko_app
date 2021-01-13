class Shop < ApplicationRecord
  belongs_to :admin
  # has_one_attached :image
  mount_uploader :shop_image, ShopImageUploader
  has_many :items, dependent: :destroy

  with_options presence: true do
    validates :name,             length: { maximum: 40 }
    validates :location,         length: { maximum: 1000 }
    validates :phone_number,     format: { with: /\A\d{1,}\z/ }
  end
  with_options presence: { message: 'が不正です' } do
    validates :opening_time
    validates :closing_time
  end

  with_options presence: { message: 'を選択してください' } do
    validates :prefecture_id
    validates :parking_id
    validates :credit_card_id
    validates :electronic_money_id
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :parking
  belongs_to :credit_card
  belongs_to :electronic_money

    # 全角とハイフンの処理
  def self.phone_number_converter(shop_params)
    shop_params[:phone_number] = shop_params[:phone_number].tr('０-９ａ-ｚＡ-Ｚ', '0-9a-zA-Z').gsub(/[-,ー]/, '')
    return shop_params
  end
end
