class UserRecipesController < ApplicationController
  def index
    @recipes = UserRecipe.where(user: current_user).includes([:recipe])
  end
end
