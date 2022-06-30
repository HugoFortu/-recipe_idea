class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :description
      t.integer :portion
      t.float :stars
      t.string :preptime
      t.string :url

      t.timestamps
    end
  end
end
