class UserCategoriesController < ApplicationController
  def index
    @shop = Shop.new
    @shops = Shop.mine(current_user)
    @ingredients = IngredientCategory.mine(current_user)
    @categories = UserCategory.mine(current_user)
  end

  def new
    @user_category = UserCategory.new
    path = Dir.pwd
    @images = Dir.chdir("#{path}/app/assets/images/categories") { Dir.glob("*.png") }
    @shops = Shop.mine(current_user)
    @shop = Shop.new
  end

  def create
    path = Dir.pwd
    @images = Dir.chdir("#{path}/app/assets/images/categories") { Dir.glob("*.png") }
    @user_category = UserCategory.new(user_category_params)
    @user_category.user = current_user
    if @user_category.save
      redirect_to user_user_categories_path(current_user)
    else
      render :new
    end
  end

  private

  def user_category_params
    params.require(:user_category).permit(:name, :image, :shop_id)
  end
end
