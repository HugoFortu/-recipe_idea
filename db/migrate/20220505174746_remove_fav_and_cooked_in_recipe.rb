class RemoveFavAndCookedInRecipe < ActiveRecord::Migration[7.0]
  def change
    remove_column :recipes, :cooked
    remove_column :recipes, :favoris
  end
end
