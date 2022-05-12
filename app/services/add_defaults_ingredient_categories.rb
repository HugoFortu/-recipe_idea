class AddDefaultsIngredientCategories
  def initialize(attributes = {})
    @user = attributes[:user_id]
  end

  def call
    shop = Shop.create(name: "Shop not defined for this category", user_id: @user)
    IngredientCategory.create(name: "Fruits et légumes", shop: shop, image: "vegetable.png", user_id: @user)
    IngredientCategory.create(name: "Poissons", shop: shop, image: "fish.png", user_id: @user)
    IngredientCategory.create(name: "Viandes", shop: shop, image: "meat.png", user_id: @user)
    IngredientCategory.create(name: "Vrac", shop: shop, image: "flour.png", user_id: @user)
    IngredientCategory.create(name: "conserves", shop: shop, image: "canned-food.png", user_id: @user)
    IngredientCategory.create(name: "divers", shop: shop, image: "grocery-cart.png", user_id: @user)
    IngredientCategory.create(name: "à renseigner", shop: shop, image: "grocery-cart.png", user_id: @user)
  end
end
