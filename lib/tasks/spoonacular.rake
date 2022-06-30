namespace :spoonacular do
  desc "fetch ingredients on Spoonacular"
  task fetch_ingredients_on_spoonacular: :environment do
    (0..100000).each do |id|
      results = SpoonacularApi.new { "food/ingredients/#{id}/information" }.call
      unless results == "pas de lien"
          if results["categoryPath"].empty?
            if !UserCategory.find_by(name: "not defined").nil?
              category = UserCategory.find_by(name: "not defined")
            else
              category = UserCategory.create(shop: Shop.first, name: "not defined")
            end
          else
            if !UserCategory.find_by(name: results["categoryPath"][-1]).nil?
              category = UserCategory.find_by(name: results["categoryPath"][-1])
            else
              category = UserCategory.create(shop: Shop.first, name: results["categoryPath"][-1])
            end
          end
        Ingredient.create(name: results["name"], user_category: category)
        puts results["name"]
      end
      puts id
    end
    ap Ingredient.all.count
    ap Ingredient.first
  end
end
