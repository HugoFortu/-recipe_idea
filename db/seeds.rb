
# Ingredient.destroy_all
# IngredientCategory.destroy_all
# Shop.destroy_all
Tag.destroy_all
puts "data destroyed"

# puts "creating shops"
# shop1 = Shop.create(name: "Biocoop", address: "68 rue Waldeck Rousseau, Lyon")
# shop2 = Shop.create(name: "Ma ferme en ville", address: "112 rue de Sèze, Lyon")
# shop3 = Shop.create(name: "Boucherie traiteur Vessiere", address: "53 rue Tête d'Or, Lyon")
# shop4 = Shop.create(name: "Spar", address: "140 avenue Thiers, Lyon")

puts "create tags"
tags = %w(Végé Vegan Entrée Plat Dessert Apéritif Boisson Salade Soupe Accompagnement)
tags << "Pizza, tarte, quiche"
tags << "Plat principal"
tags.each do |tag|
  Tag.create(name: tag)
end

