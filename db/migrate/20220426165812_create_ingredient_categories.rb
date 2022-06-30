class CreateIngredientCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredient_categories do |t|
      t.references :user_category, null: false, foreign_key: true
      t.references :ingredient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
