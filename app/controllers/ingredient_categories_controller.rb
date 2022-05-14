class IngredientCategoriesController < ApplicationController
  def index
    @ingredients = Ingredient.all
    @categories = IngredientCategory.where(user_id: current_user.id)
  end
end
