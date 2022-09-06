class UpdateUserJob < ApplicationJob
  queue_as :default

  def perform(user)
    add_defaults_user_categories(user)
  end

  private

  def add_defaults_user_categories(user)
    shop = Shop.create(name: "Shop not defined for this category", user: user)
    UserCategory.create(name: "Fruits et légumes", shop: shop, image: "categories/vegetable.png", user: user)
    UserCategory.create(name: "Poissons", shop: shop, image: "categories/fish.png", user: user)
    UserCategory.create(name: "Viandes", shop: shop, image: "categories/meat.png", user: user)
    UserCategory.create(name: "Vrac", shop: shop, image: "categories/flour.png", user: user)
    UserCategory.create(name: "conserves", shop: shop, image: "categories/canned-food.png", user: user)
    UserCategory.create(name: "divers", shop: shop, image: "categories/grocery-cart.png", user: user)
    UserCategory.create(name: "fromage", shop: shop, image: "categories/cheese.png", user: user)
    UserCategory.create(name: "à renseigner", shop: shop, image: "categories/grocery-cart.png", user: user)
  end
end

