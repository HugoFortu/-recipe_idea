class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :find_recipe, only: [:show, :edit, :update]

  def index
    @recipes = Recipe.all
  end

  def my_recipes
    @recipes = Recipe.where(user: current_user)
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    UserRecipe.create(recipe: @recipe, user: current_user)
    if @recipe.save
      redirect_to my_recipes_recipes_path
    else
      render :new
    end
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
