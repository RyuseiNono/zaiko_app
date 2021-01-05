class ShopsController < ApplicationController
  before_action :authenticate_admin!, except: [:index, :show]
  before_action :set_shop, only: [:edit, :update, :destroy]

  PER = 6
  def index
    @shops = Shop.page(params[:page]).per(PER)
    # @shops = Shop.all
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

  private

  def shop_params
    shop_params = params.require(:shop).permit(:name, :prefecture_id, :location, :phone_number, \
                                               :opening_time, :closing_time, \
                                               :parking_id, :credit_card_id, :electronic_money_id) \
                        .merge(admin_id: current_admin[:id])
    # 全角とハイフンの処理
    shop_params[:phone_number] = shop_params[:phone_number].tr('０-９ａ-ｚＡ-Ｚー', '0-9a-zA-Z-').gsub(/[−-]/, '')
    shop_params
  end

  def set_shop
    @shop = Shop.find(params[:id])
  end
end
