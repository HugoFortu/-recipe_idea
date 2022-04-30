require "open-uri"
require "nokogiri"

class ScrappMarmitonRecipes
  def initialize(attributes = {})
    @ingredient = attributes[:ingredient]
    @recipe_id = attributes[:id]
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
    doc.search
    tag =
    preptime =
    ingredients =
    steps =
    portion =
    @recipe.update()

  end
end
