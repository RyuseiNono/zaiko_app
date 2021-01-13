class ShopsController < ApplicationController
  before_action :authenticate_admin!, except: [:index, :show]
  before_action :set_shop, only: [:edit, :update, :destroy]
  before_action :user_can_edit?, only: [:edit, :update, :destroy]

  PER = 6
  def index
    @shops = Shop.order(updated_at: "DESC").page(params[:page]).per(PER)
    @shop_count = Shop.all.count
  end

  def new
    @shop = Shop.new
  end

  def confirm
    @shop = Shop.new(shop_params)
    render :new if @shop.invalid?
  end

  def create
    @shop = Shop.new(shop_params)
    render :new and return if params[:back] || !@shop.save
  end

  def edit
  end

  def update
    render :edit and return unless @shop.update(shop_params)
  end

  def destroy
    @shop.destroy
  end

  def my
    @shops = Shop.where(admin_id: current_admin[:id]).order(updated_at: "DESC").page(params[:page]).per(PER)
    @shop_count = Shop.where(admin_id: current_admin[:id]).count
  end

  private

  def shop_params
    shop_params = params.require(:shop).permit(:name, :prefecture_id, :location, :phone_number, \
                                               :opening_time, :closing_time, \
                                               :parking_id, :credit_card_id, :electronic_money_id, :shop_image, :shop_image_cache) \
                        .merge(admin_id: current_admin[:id])
    # 全角とハイフンの処理
    shop_params = Shop.phone_number_converter(shop_params)
    return shop_params
  end

  def set_shop
    @shop = Shop.find(params[:id])
  end

  def user_can_edit?
    return redirect_to root_path unless @shop.admin.id == current_admin.id
  end
end
