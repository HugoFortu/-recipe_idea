require "open-uri"
require "nokogiri"

class ScrappMarmitonRecipes
  def initialize(attributes = {})
    @ingredient = attributes[:ingredient]
    @recipe_id = attributes[:id]
    @url = attributes[:url]
    @base_url = "https://www.marmiton.org"
  end

  def search
    html = URI.open("#{@base_url}/recettes/recherche.aspx?aqt=#{@ingredient}").read
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
    html = URI.open(@recipe.url).read
    doc = Nokogiri::HTML(html, nil, "utf-8")
    tag = add_tag(doc)
    preptime = doc.search(".iDYkZP").first.text.strip
    portion = doc.search(".hYSrSW").text.strip.to_i
    steps = add_steps(doc)
    ingredients = add_ingredients(doc)
    @recipe.update(preptime: preptime, portion: portion)
  end

    def call_with_url
    html = URI.open(@url).read
    doc = Nokogiri::HTML(html, nil, "utf-8")
    name = doc.search(".itJBWW").text.strip
    stars = doc.search(".jHwZwD").text.strip
    image = doc.search(".vKBPb").first.attribute("src").value.strip
    tag = add_tag(doc)
    preptime = doc.search(".iDYkZP").first.text.strip
    portion = doc.search(".hYSrSW").text.strip.to_i
    steps = add_steps(doc)
    ingredients = add_ingredients(doc)
    Recipe.create(name: name, url: @url, stars: stars, image_url: image, preptime: preptime, portion: portion)
  end

  private

  def add_tag(doc)
    tag = doc.search(".SHRD__sc-10plygc-0")[2].text.strip
    unless Tag.find_by(name: tag).nil?
      RecipeTag.create!(recipe: @recipe, tag: Tag.find_by(name: tag))
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
    doc.search(".MuiGrid-item").each do |element|
      name = element.search(".itCXhd").text.strip.capitalize
      name = element.search(".cDbUWZ").text.strip.capitalize if name == ""
      dose = element.search(".epviYI").text.strip
      ingredient = find_ingredient(name, doc)
      IngredientRecipe.create(recipe: @recipe, ingredient: ingredient, dose: dose)
    end
  end

  def find_ingredient(name, doc)
    ingredient = Ingredient.find_by(name: name)
    if ingredient.nil?
      image = doc.search("img").attribute("src").value.strip
      category = IngredientCategory.find_by(name: "à renseigner")
      ingredient = Ingredient.create(name: name, ingredient_category: category, image: image)
    end
    ingredient
  end
end
