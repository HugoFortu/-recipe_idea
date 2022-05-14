class UserRecipesController < ApplicationController
  def index
    @user_recipes = UserRecipe.where(user: current_user).includes([:recipe])
  end

  def show
    @user_recipe = ScrappMarmitonRecipes.new(id: params[:id], user: current_user).call
  end
end
