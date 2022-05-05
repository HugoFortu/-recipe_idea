class AddFavAndCookedInUserRecipe < ActiveRecord::Migration[7.0]
  def change
    add_column :user_recipes, :cooked, :boolean, default: false
    add_column :user_recipes, :favoris, :boolean, default: falsere
  end
end
