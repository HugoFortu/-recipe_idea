class Shop < ApplicationRecord
  has_many :user_categories
  belongs_to :user

  validates :name, presence: true
end
