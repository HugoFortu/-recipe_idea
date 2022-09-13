class UserCategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :destroy]
  def index
    @shop = Shop.new
    @shops = Shop.mine(current_user)
    @ingredients = IngredientCategory.mine(current_user).includes([:ingredient, :user_category])
    @categories = UserCategory.mine(current_user)
  end

  def new
    @user_category = UserCategory.new
    path = Dir.pwd
    @images = Dir.chdir("#{path}/app/assets/images/categories") { Dir.glob("*.png") }
    @shops = Shop.mine(current_user)
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

  def edit
  end

  def update
    @user_category.update(user_category_params)
    if @user_category.save
      redirect_to user_user_categories_path(current_user)
    else
      render :edit
    end
  end

  def destroy
    @user_category.delete
    redirect_to user_user_categories_path(current_user)
  end

  private

  def set_category
    @user_category = UserCategory.find(params[:id])
  end

  def user_category_params
    params.require(:user_category).permit(:name, :image, :shop_id)
  end
end
