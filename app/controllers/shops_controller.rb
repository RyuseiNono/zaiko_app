class ShopsController < ApplicationController
  def index
    @shops = Shop.all
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
    if @shop.save
    else
      render action: :new
    end
  end

  private

  def shop_params
    shop_params = params.require(:shop).permit(:image, :name, :prefecture_id, :location, :phone_number, \
                                               :'opening_time(4i)', :'opening_time(5i)',\
                                               :'closing_time(4i)', :'closing_time(5i)', \
                                               :parking_id, :credit_card_id, :electronic_money_id)\
                        .merge(admin_id: current_admin[:id])
    # 全角とハイフンの処理
    shop_params[:phone_number] = shop_params[:phone_number].tr('０-９ａ-ｚＡ-Ｚー', '0-9a-zA-Z-').gsub(/[−-]/, '')
    # 開店時間、閉店時間の処理
    shop_params[:opening_time] = "#{shop_params['opening_time(4i)']}:#{shop_params['opening_time(5i)']}:00"
    shop_params[:closing_time] = "#{shop_params['closing_time(4i)']}:#{shop_params['closing_time(5i)']}:00"
    shop_params
  end
end
