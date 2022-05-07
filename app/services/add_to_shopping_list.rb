class AddToShoppingList
  def initialize(attributes = {})
    @list = attributes[:list]
    @recipe = attributes[:recipe]
    @user_portion = attributes[:portion]
  end

  def call
    portion_ratio = @user_portion / @recipe.portion.to_f
    @recipe.ingredient_recipes.each do |ingredient_recipe|
      new_ingredient_dose = adapt_dose(ingredient_recipe, portion_ratio)
      add_to_list(name, new_ingredient_dose)
    end

  end

  def add_to_list(name, dose)
    ingredient = Ingredient.find_by(name: name)
    list_ingredient = ListIngredient.find_or_create_by(ingredient: ingredient, list: @list)
    if list_ingredient.quantity.nil? || list_ingredient.checked == true
      quantity = dose.split(" ").join(" ")
      list_ingredient.checked = false
    else
      quantity_splitted = list_ingredient.quantity.split(" ")
      new_dose = (quantity_splitted.first.to_f) + (dose.split(" ").first.to_f)
      quantity_splitted[0] = new_dose.to_s
      quantity = quantity_splitted.join(" ")
    end
    list_ingredient.update(quantity: quantity)
  end

  private

  def adapt_dose(ingredient_recipe, portion_ratio)
    name = ingredient_recipe.ingredient.name
    dose = ingredient_recipe.dose
    dose_splitted = dose.split(" ")
    if dose_splitted[1] == "g"
      new_dose = (dose_splitted.first.to_f * portion_ratio).round(-1).to_s
    else
      new_dose = (dose_splitted.first.to_f * portion_ratio).round(1).to_s
    end
    dose_splitted[0] = new_dose
    new_ingredient_dose = dose_splitted.join(" ")
  end
end
