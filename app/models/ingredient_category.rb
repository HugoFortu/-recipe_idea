class IngredientCategory < ApplicationRecord
  belongs_to :shop
  has_many :ingredients
end
