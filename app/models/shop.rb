class Shop < ApplicationRecord
  has_many :user_categories
  belongs_to :user

  validates :name, presence: true

  scope :mine, -> (user) { where(user: user) }
end
