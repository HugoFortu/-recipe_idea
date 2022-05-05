class UserRecipe < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  has_many :steps, through: :recipe
  has_many :recipe_tags, through: :recipe
end
