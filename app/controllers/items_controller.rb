class ItemsController < ApplicationController
  def index
    @shop = Shop.find(params['shop_id'])
  end

  def new
    @shop = Shop.find(params['shop_id'])
    @item = Item.new
  end

  def create
    @shop = Shop.find(params['shop_id'])
    @item = Item.new(item_params)
    if @item.save
      item_id = Item.order(id: "DESC").limit(1).ids[0] #今投稿したitemのid取得
      items_length = @shop.items.length #データ数０か１以上で場合分けするため
      ActionCable.server.broadcast 'item_create_channel', content: {item: @item, items_length: items_length}
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      ActionCable.server.broadcast 'item_update_channel', content: {item: @item}
    end
  end

  def destroy
    @shop = Shop.find(params['shop_id'])
    @item = Item.find(params[:id])
    if @item.destroy
      items_length = @shop.items.length #データ数０か１以上で場合分けするため
      ActionCable.server.broadcast 'item_destroy_channel', content: {item: @item,items_length: items_length}
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :count).merge(shop_id: params[:shop_id])
  end

  def set_item
    @shop = Shop.find(params['shop_id'])
  end
end
