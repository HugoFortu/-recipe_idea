class UserCategoriesController < ApplicationController
  def index
    @ingredients = Ingredient.all
    @categories = UserCategory.where(user_id: current_user.id)
  end

  def new
    @user_category = UserCategory.new
    path = Dir.pwd
    @images = Dir.chdir("#{path}/app/assets/images/categories") { Dir.glob("*.png") }
    @shops = Shop.mine(current_user)
    @shop = Shop.new
  end

  def create
    @user_category = UserCategory.new(user_category_params)
    @user_category.user = current_user
    @user_category.save
  end

  private

  def user_category_params
    params.require(:user_category).permit(:name, :image, :shop)
  end
end
