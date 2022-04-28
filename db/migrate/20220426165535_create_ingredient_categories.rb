class CreateIngredientCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredient_categories do |t|
      t.references :shop, null: false, foreign_key: true
      t.string :name
      t.string :image

      t.timestamps
    end
  end
end
