class ItemsController < ApplicationController
  def index
    @shop = Shop.find(params["shop_id"])
    @items = @shop.items
  end
end
