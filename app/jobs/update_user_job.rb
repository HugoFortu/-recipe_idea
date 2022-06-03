class UpdateUserJob < ApplicationJob
  queue_as :default

  def perform(user)
    add_defaults_ingredient_categories(user)
  end

  private

  def add_defaults_ingredient_categories(user)
    shop = Shop.create(name: "Shop not defined for this category", user: user)
    IngredientCategory.create(name: "Fruits et légumes", shop: shop, image: "vegetable.png", user: user)
    IngredientCategory.create(name: "Poissons", shop: shop, image: "fish.png", user: user)
    IngredientCategory.create(name: "Viandes", shop: shop, image: "meat.png", user: user)
    IngredientCategory.create(name: "Vrac", shop: shop, image: "flour.png", user: user)
    IngredientCategory.create(name: "conserves", shop: shop, image: "canned-food.png", user: user)
    IngredientCategory.create(name: "divers", shop: shop, image: "grocery-cart.png", user: user)
    IngredientCategory.create(name: "à renseigner", shop: shop, image: "grocery-cart.png", user: user)
  end
end
