class ItemsController < ApplicationController
  before_action :authenticate_admin!, except: [:index]
  before_action :set_shop, only: [:index, :new, :update, :create, :destroy]
  before_action :set_item, only: [:update, :destroy]
  before_action :user_can_edit?, only: [:new, :update, :create, :destroy]

  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      item_id = Item.order(id: "DESC").limit(1).ids[0] #今投稿したitemのid取得
      items_length = @shop.items.length #データ数０か１以上で場合分けするため
      ActionCable.server.broadcast 'item_create_channel', content: {item: @item, items_length: items_length}
    end
  end

  def update
    if @item.update(item_params)
      ActionCable.server.broadcast 'item_update_channel', content: {item: @item}
    end
  end

  def destroy
    if @item.destroy
      items_length = @shop.items.length #データ数０か１以上で場合分けするため
      ActionCable.server.broadcast 'item_destroy_channel', content: {item: @item,items_length: items_length}
    end
  end

  private
  def item_params
    item_params = params.require(:item).permit(:name, :count, :price).merge(shop_id: params[:shop_id])
    # 全角の処理
    item_params[:price] = item_params[:price].tr('０-９', '0-9')
    # 全角の処理
    item_params
  end

  def set_shop
    @shop = Shop.find(params[:shop_id])
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def user_can_edit?
    return redirect_to root_path unless @shop.admin.id == current_admin.id
  end
end
