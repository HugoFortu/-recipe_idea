class Recipe < ApplicationRecord
  has_many :recipe_tags, dependent: :destroy
  has_many :tags, through: :recipe_tags, dependent: :destroy
  has_many :ingredient_recipes, dependent: :destroy
  has_many :ingredients, through: :ingredient_recipes
  has_many :steps, dependent: :destroy
  has_many :mealplan, dependent: :destroy
  has_many :user_recipes, dependent: :destroy
  has_many :users, through: :user_recipes

  validates :name, presence: true

  scope :recorded, -> { where.not(preptime: nil) }
  scope :not_recorded, -> { where(preptime: nil) }

  AUTHORIZED_RATINGS = (1..5)
end

