class UserCategory < ApplicationRecord
  belongs_to :shop
  belongs_to :user
  has_many :ingredient_categories
  has_many :ingredients, through: :ingredient_categories

  scope :mine, -> (user) { where(user: user) }
end
