class CreateListIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :list_ingredients do |t|
      t.string :quantity
      t.boolean :checked, default: false
      t.references :list, null: false, foreign_key: true
      t.references :ingredient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
