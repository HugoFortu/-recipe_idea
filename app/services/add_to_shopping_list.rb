class AddToShoppingList
  def initialize(attributes = {})
    @list = attributes[:list_id]
    @recipe = attributes[:recipe_id]
    @user_portion = attributes[:portion]
  end

  def adapt_to_guests
    portion_ratio = @user_portion / @recipe.portion
    @recipe.ingredient_recipes.each do |ingredient_recipe|
      name = ingredient_recipe.ingredient.name
      dose_splitted = ingredient_recipe.dose.split(" ")
      new_dose = dose_splitted.first.to_i * portion_ratio
      dose_splitted[0] = new_dose.to_s
      new_ingredient_dose = dose_splitted.join(" ")
      add_to_list(name, new_ingredient_dose)
    end
  end

  def add_to_list(name, dose)
    ingredient = Ingredient.find_by(name: name)
    list_ingredient = ListIngredient.find_or_create_by(ingredient: ingredient, list: @list)
    if list_ingredient.quantity.nil? || list_ingredient.checked == true
      quantity = dose
      list_ingredient.checked = false
    else
      quantity_splitted = list_ingredient.quantity.split(" ")
      new_dose = (quantity_splitted.first.to_i) + (dose.split(" ").first.to_i)
      quantity_splitted[0] = new_dose.to_s
      quantity = quantity_splitted.join(" ")
    end
    list_ingredient.update(quantity: quantity)
  end
end
