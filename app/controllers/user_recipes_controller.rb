class UserRecipesController < ApplicationController
  before_action :find_user_recipe, only: [:show]
  def index
    @user_recipes = UserRecipe.where(user: current_user).includes([:recipe])
  end

  def show
    if @user_recipe.nil?
      @user_recipe = ScrappMarmitonRecipes.new(id: params[:id], user: current_user).call
    end
  end

  private

  def find_user_recipe
    @user_recipe = UserRecipe.find(params[:id])
  end
end
