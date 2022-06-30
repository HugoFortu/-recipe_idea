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
    if Recipe.find(params[:recipe_id]).portion == nil
      @user_recipe = ScrappMarmitonRecipes.new(id: params[:recipe_id], user: current_user).call
    else
      recipe = Recipe.find(params[:recipe_id])
      @user_recipe = UserRecipe.find_or_create_by(recipe: recipe, user: current_user)
      recipe.ingredients.each do |ingredient|
        category = UserCategory.find_by(user_id: current_user, name: "à renseigner")
        if IngredientCategory.mine(current_user).find_by(ingredient: ingredient).nil?
          IngredientCategory.create(ingredient: ingredient, user_category: category)
        end
      end
    end
    redirect_to recipe_path(params[:recipe_id])
  end

  def add_to_list
    @user_recipe = UserRecipe.find(params[:id])
  end

  private

  def find_user_recipe
    @user_recipe = UserRecipe.find(params[:id])
  end
end
