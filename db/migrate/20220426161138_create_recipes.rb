class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :description
      t.integer :portion
      t.integer :stars
      t.string :preptime
      t.boolean :cooked, default: false
      t.string :url
      t.boolean :favoris, default: false

      t.timestamps
    end
  end
end
