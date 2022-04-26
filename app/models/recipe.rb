class Recipe < ApplicationRecord
  has_many :recipe_tags, dependent: :destroy
  has_many :tags, through: :recipe_tags
  has_many :ingredient_recipes, dependent: :destroy
  has_many :ingredients, through: :ingredient_recipes

end
