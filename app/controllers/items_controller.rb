class ItemsController < ApplicationController
  before_action :authenticate_admin!, except: [:index, :search]
  before_action :set_shop, only: [:index, :new, :update, :create, :destroy]
  before_action :set_item, only: [:edit, :update, :destroy]
  before_action :user_can_edit?, only: [:new, :update, :create, :destroy]

  def index
    binding.pry
  end

  def new
    @item = Item.new
  end

  def edit
  end

  def create
    @item = Item.new(item_params)
    return unless @item.save
  end

  def update
    return unless @item.update(item_params)
  end

  def destroy
    return unless @item.destroy
  end

  def search
    @items = Item.search(params[:keyword]).includes(:shop).order(count: 'DESC')
    @keyword = params[:keyword]
  end

  private

  def item_params
    item_params = params.require(:item).permit(:name, :count, :price).merge(shop_id: params[:shop_id])
    # 全角の処理
    Item.price_converter(item_params)
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
