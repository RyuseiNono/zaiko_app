class AddShopImageToShops < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :shop_image, :string
  end
end
