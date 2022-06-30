class UpdateUserJob < ApplicationJob
  queue_as :default

  def perform(user)
    add_defaults_user_categories(user)
  end

  private

  def add_defaults_user_categories(user)
    shop = Shop.create(name: "Shop not defined for this category", user: user)
    UserCategory.create(name: "Fruits et légumes", shop: shop, image: "vegetable.png", user: user)
    UserCategory.create(name: "Poissons", shop: shop, image: "fish.png", user: user)
    UserCategory.create(name: "Viandes", shop: shop, image: "meat.png", user: user)
    UserCategory.create(name: "Vrac", shop: shop, image: "flour.png", user: user)
    UserCategory.create(name: "conserves", shop: shop, image: "canned-food.png", user: user)
    UserCategory.create(name: "divers", shop: shop, image: "grocery-cart.png", user: user)
    UserCategory.create(name: "fromage", shop: shop, image: "cheese.png", user: user)
    UserCategory.create(name: "à renseigner", shop: shop, image: "grocery-cart.png", user: user)
  end
end
