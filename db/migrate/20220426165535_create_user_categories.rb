class CreateUserCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :user_categories do |t|
      t.references :shop, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :image

      t.timestamps
    end
  end
end
