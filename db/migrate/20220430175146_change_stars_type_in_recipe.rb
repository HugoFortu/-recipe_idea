class ChangeStarsTypeInRecipe < ActiveRecord::Migration[7.0]
  def change
    change_column :recipes, :stars, :float
  end
end
