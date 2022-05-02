class ChangeTypeOfDoseInIngredientRecipe < ActiveRecord::Migration[7.0]
  def change
    change_column :ingredient_recipes, :dose, :string
  end
end
