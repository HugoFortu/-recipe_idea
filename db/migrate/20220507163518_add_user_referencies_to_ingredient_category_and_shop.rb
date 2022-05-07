class AddUserReferenciesToIngredientCategoryAndShop < ActiveRecord::Migration[7.0]
  def change
    add_reference :ingredient_categories, :user, null: false, foreign_key: true
    add_reference :shops, :user, null: false, foreign_key: true
  end
end
