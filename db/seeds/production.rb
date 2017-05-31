#this file add populated the tables with important data
require 'csv'

puts "Seeding tables"

units = ['oz.', 'lb.', 'pack', 'gal.', 'min.']
units.each { |unit_name| Unit.create(name: unit_name) }

degrees = ['Low', 'Medium-Low', 'Medium', 'Medium-High', 'High', 'Very High', 'Variable']
degrees.each { |degree_name| Degree.create(name: degree_name) }

ingredient_categories = ['Fermentables', 'Hops', 'Yeasts', 'Others']
ingredient_categories.each { |ingredient_category| Category.create(name: ingredient_category) }

ingredient_kinds = [
  'Acidulated malt (Grain)',
  'Base malt (Grain)',
  'Crystal malt (Grain)',
  'Dry',
  'Extract (Dry Extract)',
  'Extract (Liquid Extract)',
  'Fining',
  'Flavor',
  'Fruit',
  'Gluten-free malt (Grain)',
  'Herb',
  'Leaf/Whole',
  'Liquid',
  'Other',
  'Other (Grain)',
  'Pellet',
  'Plug',
  'Raw',
  'Raw (Adjunct)',
  'Raw (Dry Extract)',
  'Raw (Grain)',
  'Roasted malt (Grain)',
  'Sugar',
  'Spice',
  'Water Agt'
]
ingredient_kinds.each { |ingredient_kind| Kind.create(name: ingredient_kind) }

ingredient_uses = [
  'Aroma',
  'Boil',
  'Bottling',
  'Dry Hop',
  'First Wort',
  'Kegging',
  'Mash',
  'Other',
  'Primary',
  'Secondary'
]
ingredient_uses.each { |ingredient_use| Use.create(name: ingredient_use) }

origins = [
  'America',
  'Belgium',
  'Canadian',
  'Danstar',
  'Fermentis',
  'Finland',
  'Germany',
  'Ireland',
  'Mangrove Jack\'s',
  'The Yeast Bay',
  'United Kingdom',
  'White Labs',
  'Wyeast'
]
origins.each { |origin_name| Origin.create(name: origin_name) }

csv_ingredients = File.read(Rails.root.join('db', 'seeds', 'ingredients.csv'))
ingredients = CSV.parse(csv_ingredients, :headers => true)

total = ingredients.count
ingredients.each_with_index do |ingredient, index|
  puts "added #{index+1}/#{total} - #{ingredient['name']}"
  the_ingredient = Ingredient.create(
    name: ingredient['name'],
    category_id: (ingredient['category'].blank? ? '' : Category.where(name: ingredient['category']).first.id),
    origin_id:  (ingredient['origin'].blank? ? '' : Origin.where(name: ingredient['origin']).first.id),
    kind_id: (ingredient['kind'].blank? ? '' : Kind.where(name: ingredient['kind']).first.id),
    use_id: (ingredient['use'].blank? ? '' : Use.where(name: ingredient['use']).first.id),
    alcohol_tolerance_id: (ingredient['alcohol_tolerance'].blank? ? '' : Degree.where(name: ingredient['alcohol_tolerance']).first.id),
    flocculation_id: (ingredient['flocculation'].blank? ? '' : Degree.where(name: ingredient['flocculation']).first.id),
    color: (ingredient['color'].blank? ? '' : ingredient['color']),
    ppg: (ingredient['ppg'].blank? ? '' : ingredient['ppg']),
    alpha: (ingredient['alpha'].blank? ? '' : ingredient['alpha']),
    product_id: (ingredient['product_id'].blank? ? '' : ingredient['product_id'])
  )
end
