class Ingredient < ApplicationRecord
  belongs_to :ingredient_category
  has_many :ingredient_recipes
  has_many :recipes, through: :ingredient_recipes
  has_many :blacklisted_ingredients
  has_many :users, through: :blacklisted_ingredients

  validates :name, presence: true, uniqueness: true
end
