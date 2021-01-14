class FavoritesController < ApplicationController
  before_action :set_shop, only: [:create, :destroy]

  def create
    if user_signed_in?
      @favorite = Favorite.create(user_id: current_user.id, shop_id: @shop.id)
    elsif admin_signed_in?
      @favorite = Favorite.create(admin_id: current_admin.id, shop_id: @shop.id)
    end
    redirect_to root_path
  end

  def destroy
    if user_signed_in?
      @favorite = Favorite.find_by(user_id: current_user.id, shop_id: @shop.id)
      @favorite.destroy
    elsif admin_signed_in?
      @favorite = Favorite.find_by(admin_id: current_admin.id, shop_id: @shop.id)
      @favorite.destroy
    end
    redirect_to root_path
  end

  private
  def set_shop
    @shop = Shop.find(params[:shop_id])
  end
end
