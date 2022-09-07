class ShopsController < ApplicationController
  def create
    @shop = Shop.new(shop_params)
    @shop.user = current_user
    if @shop.save
      redirect_to user_user_categories_path(current_user)
    else
      render "user_categories/index"
    end
  end

  def new
    @shop = Shop.new
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :address, :photo)
  end
end
