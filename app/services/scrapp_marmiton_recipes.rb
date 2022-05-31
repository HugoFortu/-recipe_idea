require "open-uri"
require "nokogiri"

MEAT_AND_FISH = %w(Agneau Porc Abats Poulet Boeuf Veau Mouton Canard Anchois Andouille Andouillette Anguille Bacon Baudroie Beef Steak Bifteck Bigorneau Dinde Boudin Viande Bresaola Bulot Cabillaud Caille Calamar Crabe Cassoulet Cervelas Saucisse Charcuteries Chapon Chipolata Chorizo Daurade Jambon Diot Dorade Faisan Faux-filet filet foie poisson Crevette Gambas Coppa Crevettes Lapin Gésiers Haddock Hareng Homard Huître Jambonneau lotte Cochon Langouste Langoustine Lard Lardons Lieu Limande Maquereau Sardine Merlu Merlan Mérou Moelle Mortadelle Morue Moules Pétoncle saint-jacques paleron palourde oie pancetta Panga Pastrami pâté paupiette saumon thon pintade poitrine poule poulpe praire écrevisse raie rillettes rosbif rosette rognons rouget rumsteak rumsteck saint-pierre salami saucisson scampi seiche sole surimi tourteau tripes truite turbot volaille)
MEATS_AND_FISHES = MEAT_AND_FISH.map { |element| element.pluralize }

class ScrappMarmitonRecipes
  def initialize(attributes = {})
    @ingredient = attributes[:ingredient]
    @recipe_id = attributes[:id]
    @url = attributes[:url]
    @base_url = "https://www.marmiton.org"
    @current_user = attributes[:user]
  end

  def search
    html = URI("#{@base_url}/recettes/recherche.aspx?aqt=#{@ingredient}").read
    doc = Nokogiri::HTML(html, nil, "utf-8")
    results = []
    doc.search(".gACiYG").first(10).each do |element|
      name = element.search("h4").text.strip
      image = element.search(".hiKnrc img").attribute("src").value.strip
      rating = element.search(".jHwZwD").text.strip
      url = @base_url + (element.attribute("href").value.strip)
      results << Recipe.create(name: name, image_url: image, stars: rating, url: url)
    end
    results
  end

  def call
    @recipe = Recipe.find(@recipe_id)
    html = URI(@recipe.url).read
    doc = Nokogiri::HTML(html, nil, "utf-8")
    tag = add_tag(doc)
    preptime = doc.search(".iDYkZP").first.text.strip
    portion = doc.search(".hYSrSW").text.strip.to_i
    steps = add_steps(doc)
    ingredients = add_ingredients(doc)
    @recipe.update(preptime: preptime, portion: portion)
    Recipe.not_recorded.destroy_all
    UserRecipe.create(user: @current_user, recipe: @recipe)
  end

    def call_with_url
    html = URI(@url).read
    doc = Nokogiri::HTML(html, nil, "utf-8")
    name = doc.search(".itJBWW").text.strip
    stars = doc.search(".jHwZwD").text.strip
    image = doc.search(".vKBPb").first.attribute("src").value.strip
    preptime = doc.search(".iDYkZP").first.text.strip
    portion = doc.search(".hYSrSW").text.strip.to_i
    steps = add_steps(doc)
    ingredients = add_ingredients(doc)
    tag = add_tag(doc)
    recipe = Recipe.create(name: name, url: @url, stars: stars, image_url: image, preptime: preptime, portion: portion)
    UserRecipe.create(user: @current_user, recipe: recipe)
  end

  private

  def add_tag(doc)
    tag = doc.search(".SHRD__sc-10plygc-0")[2].text.strip
    unless Tag.find_by(name: tag).nil?
      RecipeTag.create(recipe: @recipe, tag: Tag.find_by(name: tag))
    end
  end

  def add_steps(doc)
    counter = 1
    doc.search(".jFIVDw").each do |step|
      description = step.text.strip.gsub(/(\r?\n|\r)/, " ")
      Step.create(description: description, order: counter, recipe: @recipe)
      counter += 1
    end
  end

  def add_ingredients(doc)
    tags = []
    doc.search(".MuiGrid-item").each do |element|
      name = element.search(".itCXhd").text.strip.capitalize
      name = element.search(".cDbUWZ").text.strip.capitalize if name == ""
      dose = element.search(".epviYI").text.strip
      ingredient = find_ingredient(name, doc)
      tags << "végé" if (count_elements(MEAT_AND_FISH, ingredient) == 0) || (count_elements(MEATS_AND_FISHES, ingredient) == 0)
      IngredientRecipe.create(recipe: @recipe, ingredient: ingredient, dose: dose)
    end
    RecipeTag.create(recipe: @recipe, tag: Tag.find_by(name: "Végé")) if tags.include?("végé")
  end

  def find_ingredient(name, doc)
    pluralized_name = name.pluralize
    ingredient = Ingredient.find_by(name: pluralized_name)
    if ingredient.nil?
      image = doc.search("img").attribute("src").value.strip
      category = IngredientCategory.find_by(name: "à renseigner")
      ingredient = Ingredient.create(name: pluralized_name, ingredient_category: category, image: image)
    end
    ingredient
  end

  def count_elements(constant, ingredient)
    constant.count {|element| element.match(/#{ingredient.name}/i)}
  end
end
