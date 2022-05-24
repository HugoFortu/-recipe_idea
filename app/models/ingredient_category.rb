class IngredientCategory < ApplicationRecord
  belongs_to :shop
  belongs_to :user
  has_many :ingredients
end
