class ShopsController < ApplicationController
  def index
    @shops = Shop.all
  end

  def new
    @shop = Shop.new
  end

  def create

  end

  private

end
