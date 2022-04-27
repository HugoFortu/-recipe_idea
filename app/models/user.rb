class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    has_many :blacklisted_ingredients, dependent: :destroy
    has_many :ingredients, through: :blacklisted_ingredients
    has_many :user_recipes, dependent: :destroy
    has_many :recipes, through: :user_recipes
end
