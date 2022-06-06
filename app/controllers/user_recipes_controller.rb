class UserRecipesController < ApplicationController
  before_action :find_user_recipe, only: [:show]

  def index
    @user_recipes = UserRecipe.where(user: current_user).includes([:recipe])
  end

  def show
    @ingredients = @user_recipe.recipe.ingredient_recipes.includes(:ingredient)
    @steps = @user_recipe.recipe.steps
  end

  def create
    @user_recipe = ScrappMarmitonRecipes.new(id: params[:recipe_id], user: current_user).call

    redirect_to user_recipe_path(@user_recipe)
  end

  def add_to_list
    @user_recipe = UserRecipe.find(params[:id])
  end

  private

  def find_user_recipe
    @user_recipe = UserRecipe.find(params[:id])
  end
end
