class Shop < ApplicationRecord
  has_many :ingredient_categories

  validates :name, presence: true
  validates :address, presence: true, uniqueness: true
end
