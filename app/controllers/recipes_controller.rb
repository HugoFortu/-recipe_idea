class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :find_recipe, only: [:show, :edit, :update]

  def index
    if user_signed_in?
      @pagy, @recipes = pagy(Recipe.recorded)
      @tags =  Tag.joins(:recipe_tags).distinct

      if params[:ingredient]
        Recipe.not_recorded.includes([:recipe_tags, :ingredient_recipes, :steps, :mealplan, :user_recipes]).destroy_all
        @new_recipes = ScrappMarmitonRecipes.new(ingredient: params[:ingredient], user: current_user).search
      end

      if params[:tag] && params[:tag][:ids].present?
        @recipes = @recipes.joins(:tags).where(tags: { id: params[:tag][:ids] }).distinct
      end
    else
      redirect_to home_path
    end
  end

  def show
    @ingredients = @recipe.ingredient_recipes.includes(:ingredient)
    @steps = @recipe.steps
  end

  def edit
  end

  def update
    @recipe.update(recipe_params)
    redirect_to recipe_path(@recipe)
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :portion, :stars, :preptime, :url)
  end

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end
end
