class Item < ApplicationRecord
  belongs_to :shop
  with_options presence: true do
    validates :name
    validates :price, numericality: { only_integer: true }, length: { maximum: 8 }
    validates :count, numericality: { only_integer: true }, length: { maximum: 2 }
  end

    # 全角の処理
  def self.price_converter(item_params)
    item_params[:price] = item_params[:price].tr('０-９', '0-9')
    return item_params
  end
end
