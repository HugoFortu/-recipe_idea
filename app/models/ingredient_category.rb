class IngredientCategory < ApplicationRecord
  belongs_to :shop
  belongs_to :user
  has_many :ingredients

  scope :mine, -> { where(user_id: User.find(params[:id])) }
end
