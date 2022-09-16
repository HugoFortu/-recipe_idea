require "open-uri"
require "nokogiri"

class ScrappMarmitonRecipes
  MEAT_AND_FISH = ["agneau", "porc", "abats", "poulet", "boeuf", "veau", "mouton", "canard", "anchois", "andouille", "andouillette", "anguille", "bacon", "baudroie", "beef", "steak", "bifteck", "bigorneau", "dinde", "boudin", "viande", "bresaola", "bulot", "cabillaud", "caille", "calamar", "crabe", "cassoulet", "cervelas", "saucisse", "charcuteries", "chapon", "chipolata", "chorizo", "daurade", "jambon", "diot", "dorade", "faisan", "faux-filet", "filet", "foie", "poisson", "crevette", "gambas", "coppa", "crevettes", "lapin", "gésiers", "haddock", "hareng", "homard", "huître", "jambonneau", "lotte", "cochon", "langouste", "langoustine", "lard", "lardons", "lieu", "limande", "maquereau", "sardine", "merlu", "merlan", "mérou", "moelle", "mortadelle", "morue", "moules", "pétoncle", "saint-jacques", "paleron", "palourde", "oie", "pancetta", "panga", "pastrami", "pâté", "paupiette", "saumon", "thon", "pintade", "poitrine", "poule", "poulpe", "praire", "écrevisse", "raie", "rillettes", "rosbif", "rosette", "rognons", "rouget", "rumsteak", "rumsteck", "saint-pierre", "salami", "saucisson", "scampi", "seiche", "sole", "surimi", "tourteau", "tripes", "truite", "turbot", "volaille"]
  MEATS_AND_FISHES = ["agneaux", "porcs", "abats", "poulets", "boeufs", "veaux", "moutons", "canards", "anchois", "andouilles", "andouillettes", "anguilles", "bacons", "baudroies", "beefs", "steaks", "biftecks", "bigorneaux", "dindes", "boudins", "viandes", "bresaolas", "bulots", "cabillauds", "cailles", "calamars", "crabes", "cassoulets", "cervelas", "saucisses", "charcuteries", "chapons", "chipolatas", "chorizos", "daurades", "jambons", "diots", "dorades", "faisans", "faux-filets", "filets", "foies", "poissons", "crevettes", "gambas", "coppas", "crevettes", "lapins", "gesiers", "haddocks", "harengs", "homards", "huitres", "jambonneaux", "lottes", "cochons", "langoustes", "langoustines", "lards", "lardons", "lieus", "limandes", "maquereaux", "sardines", "merlus", "merlans", "merous", "moelles", "mortadelles", "morues", "moules", "petoncles", "saint-jacques", "palerons", "palourdes", "oies", "pancettas", "pangas", "pastramis", "pates", "paupiettes", "saumons", "thons", "pintades", "poitrines", "poules", "poulpes", "praires", "ecrevisses", "raies", "rillettes", "rosbifs", "rosettes", "rognons", "rougets", "rumsteaks", "rumstecks", "saint-pierres", "salamis", "saucissons", "scampis", "seiches", "soles", "surimis", "tourteaux", "tripes", "truites", "turbots", "volailles"]

  def initialize(attributes = {})
    @ingredient = attributes[:ingredient]
    @recipe_id = attributes[:id]
    @url = attributes[:url]
    @base_url = "https://www.marmiton.org"
    @current_user = attributes[:user]
  end

  def search
    html = URI("#{@base_url}/recettes/recherche.aspx?aqt=#{I18n.transliterate(@ingredient)}").read
    doc = Nokogiri::HTML(html, nil, "utf-8")
    results = []
    doc.search(".gACiYG").first(10).each do |element|
      name = element.search("h4").text.strip
      # attribute("data-src") or attribute("src")
      image = element.search(".hiKnrc img").attribute("src").value.strip
      image = element.search(".hiKnrc img").attribute("data-src").value.strip if image.first(4) == "data"
      rating = element.search(".jHwZwD").text.strip
      url = @base_url + (element.attribute("href").value.strip)
      results << Recipe.create(name: name, image_url: image, stars: rating, url: url) if Recipe.find_by(name: name) == nil
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
    Recipe.not_recorded.includes([:mealplan, :steps, :ingredient_recipes, :recipe_tags]).destroy_all
    UserRecipe.find_or_create_by(recipe: @recipe, user: @current_user)
  end

  def call_with_url
    html = URI(@url).read
    doc = Nokogiri::HTML(html, nil, "utf-8")
    name = doc.search(".itJBWW").text.strip
    stars = doc.search(".jHwZwD").text.strip
    image = doc.search(".vKBPb").first.attribute("src").value.strip
    image = doc.search(".vKBPb").first.attribute("data-src").value.strip if image.first(4) == "data"
    preptime = doc.search(".iDYkZP").first.text.strip
    portion = doc.search(".hYSrSW").text.strip.to_i
    steps = add_steps(doc)
    ingredients = add_ingredients(doc)
    tag = add_tag(doc)
    recipe = Recipe.create(name: name, url: @url, stars: stars, image_url: image, preptime: preptime, portion: portion)
    UserRecipe.find_or_create_by(recipe: @recipe, user: @current_user)
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
      # attribute("data-src") or attribute("src")
      image = element.search("img").attribute("data-src").value.strip
      ingredient = find_ingredient(name, doc, image)
      if (ingredient.name.downcase != "oeuf" && ingredient.name.downcase != "oeufs")
        (count_elements(MEAT_AND_FISH, ingredient.name.downcase) != 0 || count_elements(MEATS_AND_FISHES, ingredient.name.downcase) != 0) ? tags << "meat" :  tags << "végé"
      else
        tags << "végé"
      end
      IngredientRecipe.create(recipe: @recipe, ingredient: ingredient, dose: dose)
    end
    RecipeTag.create(recipe: @recipe, tag: Tag.find_by(name: "Végé")) unless tags.include?("meat")
  end

  def find_ingredient(name, doc, image)
    pluralized_name = self.pluralize_name(name)
    ingredient = Ingredient.find_by(name: name)
    if ingredient.nil?
      ingredient = Ingredient.create(name: name, image: image)
    end
    category = UserCategory.find_by(user_id: @current_user, name: "à renseigner")
    if IngredientCategory.mine(@current_user).find_by(ingredient: ingredient).nil?
      IngredientCategory.create(ingredient: ingredient, user_category: category)
    end
    ingredient
  end

  def count_elements(constant, ingredient)
    constant.count {|element| element.match(/#{ingredient}/i)}
  end

  def pluralize_name(name)
    last_name = name.split(" ").last
    plural_last_name = JSON.parse(URI("https://french-pluralize-api.herokuapp.com/#{I18n.transliterate(last_name)}").read)["plural"]
    name.gsub(/#{last_name}/, plural_last_name)
  end
end
