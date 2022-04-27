require "open-uri"
require 'json'

class SpoonacularApi
  def initialize
    if block_given?
      @url = "https://api.spoonacular.com/#{yield}?apiKey=#{ENV["SPOONACULAR_API_KEY"]}"
    end
  end

  def call
    result = URI.open(@url,
      "Content-Type"=>"application/json").read
      JSON.parse(result)
    rescue
      p "pas de lien"
  end

end

