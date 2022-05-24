class Shop < ApplicationRecord
  has_many :ingredient_categories
  belongs_to :user

  validates :name, presence: true
end
