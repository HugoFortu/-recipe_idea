class IngredientCategory < ApplicationRecord
  belongs_to :user_category
  belongs_to :ingredient

  scope :without_cat, -> (user) { where(user_category_id: (UserCategory.find_by(user: user, name: "à renseigner")).id) }
  scope :not_exist_for_user, -> (user) { where(user_category_id: (UserCategory.find_by(user: user)).id) }
end
