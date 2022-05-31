class ListsController < ApplicationController
  before_action :set_params, only: [:show, :destroy]

  def show
    if params[:portion]
      user_recipe = UserRecipe.find(params[:user_recipe_id])
      AddToShoppingList.new(list: @list, user_recipe: user_recipe, portion: params[:portion].to_i).call
      @list
    end
    @list_ingredients = ListIngredient.where(list: @list).includes([:ingredient])
  end

  def destroy
    @list_ingredients = ListIngredient.where(list: @list)
    @list_ingredients.where(checked: true).destroy_all

    redirect_to list_path(@list)
  end

  private

  def set_params
    @list = List.find(params[:id])
  end
end
