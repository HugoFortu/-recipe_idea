class Ingredient < ApplicationRecord
  has_many :ingredient_categories
  has_many :user_categories, through: :ingredient_categories
  has_many :ingredient_recipes
  has_many :recipes, through: :ingredient_recipes
  has_many :blacklisted_ingredients
  has_many :users, through: :blacklisted_ingredients
  has_many :list_ingredients

  validates :name, presence: true, uniqueness: true
end
