class ShopsController < ApplicationController
  def create
    @shop = Shop.new(shop_params)
    @shop.user = current_user
    @shop.save
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :address, :photo)
  end
end
