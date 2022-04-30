class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :find_recipe, only: [:show, :edit, :update]

  def index
    @recipes = Recipe.includes(:steps, :tags)
  end

  def my_recipes
    @recipes = Recipe.where(user: current_user)
  end

  def show
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
