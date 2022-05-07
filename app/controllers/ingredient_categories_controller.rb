class IngredientCategoriesController < ApplicationController
  def index
    if IngredientCategory.where(user_id: current_user.id) == []
      add_defaults_components
      puts " premier puts"
    end
    puts "zut zut zut"
    @ingredients = Ingredient.all
    @categories = IngredientCategory.where(user_id: current_user.id)
  end

  private

  def add_defaults_components
    puts "je suis dans add_defaults_components"
    AddDefaultsIngredientCategories.new(user_id: current_user.id).call
  end
end
