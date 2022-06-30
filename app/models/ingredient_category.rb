class IngredientCategory < ApplicationRecord
  belongs_to :user_category
  belongs_to :ingredient

  scope :without_cat, -> (user) { where(user_category_id: (UserCategory.find_by(user: user, name: "à renseigner")).id) }
  scope :mine, -> (user) { where(user_category: UserCategory.mine(user)) }
end
