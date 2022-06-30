class UserCategoriesController < ApplicationController
  def index
    @ingredients = Ingredient.all
    @categories = UserCategory.where(user_id: current_user.id)
  end
end
