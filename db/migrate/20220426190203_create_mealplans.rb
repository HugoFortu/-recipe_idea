class CreateMealplans < ActiveRecord::Migration[7.0]
  def change
    create_table :mealplans do |t|
      t.datetime :plan_date
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end
  end
end
