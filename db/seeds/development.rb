#this is for demo production
require 'csv'

puts "Seeding tables"
puts "*------ creating ingredient ancillary tables"

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

puts "**----- adding ingredients"

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
    alcohol_tolerance_id: (ingredient['alcohol_tolerance'].blank? ? '' : Degree.where(name: ingredient['alcohol_tolerance']).first.id),
    flocculation_id: (ingredient['flocculation'].blank? ? '' : Degree.where(name: ingredient['flocculation']).first.id),
    color: (ingredient['color'].blank? ? '' : ingredient['color']),
    ppg: (ingredient['ppg'].blank? ? '' : ingredient['ppg']),
    alpha: (ingredient['alpha'].blank? ? '' : ingredient['alpha']),
    product_id: (ingredient['product_id'].blank? ? '' : ingredient['product_id'])
  )
end

puts "***---- creating example users"

recipe_user = User.create(
  username: "jonlink",
  email: "jonlink@email.com",
  password: "testtest"
)
rating_user = User.create(
  username: "brylink",
  email: "brylink@email.com",
  password: "testtest"
)
rating_user2 = User.create(
  username: "roblink",
  email: "roblink@email.com",
  password: "testtest"
)

puts "****--- creating example recipe"

example_recipe = Recipe.create(
   user_id: recipe_user.id,
   name: "Russian Imperial Stout",
   boil_gravity: 1.074,
   original_gravity: 1.096,
   final_gravity: 1.02,
   boil_time: 90,
   batch_size: 5,
   boil_size: 6.5
)

example_recipe2 = Recipe.create(
   user_id: recipe_user.id,
   name: "American IPA",
   boil_gravity: 1.044,
   original_gravity: 1.061,
   final_gravity: 1.017,
   boil_time: 60,
   batch_size: 6,
   boil_size: 7
)

puts "*****-- adding ingredients to example recipe"

ingredient_list = [
  {name: 'Pale 2-Row', amount: 13, unit: 'lb.', time: ''},
  {name: 'Flaked Oats', amount: 2, unit: 'lb.', time: ''},
  {name: 'Chocolate', amount: 1, unit: 'lb.', time: ''},
  {name: 'Black Patent', amount: 1, unit: 'lb.', time: ''},
  {name: 'Roasted Barley', amount: 1, unit: 'lb.', time: ''},
  {name: 'Caramel / Crystal 15L', amount: 1, unit: 'lb.', time: ''},
  {name: "Carapils", amount: 0.5, unit: 'lb.', time: ''},
  {name: 'Willamette', amount: 4, unit: 'oz.', time: 90},
  {name: 'Cocoa Nibs', amount: 4, unit: 'oz.', time: 15},
  {name: 'San Diego Super Yeast', amount: 1, unit: 'pack', time: ''}
]
total = ingredient_list.count
ingredient_list.each_with_index do |ingredient, index|
  puts "#{index+1}/#{total} - #{ingredient[:name]}"
  RecipeIngredient.create(
    recipe_id: example_recipe.id,
    ingredient_id: Ingredient.where(name: ingredient[:name]).first.id,
    amount: ingredient[:amount],
    unit_id: Unit.where(name: ingredient[:unit]).first.id,
    time: ingredient[:time]
  )
end

ingredient_list = [
  {name: 'Dry Malt Extract - Extra Light', amount: 6, unit: 'lb.', time: '', use: ''},
  {name: 'Munich - Light 10L', amount: 1.2, unit: 'lb.', time: '', use: ''},
  {name: 'CaraFoam', amount: 0.5, unit: 'lb.', time: '', use: ''},
  {name: 'Caramel / Crystal 60L', amount: 0.5, unit: 'lb.', time: '', use: ''},
  {name: 'Melanoidin', amount: 0.5, unit: 'lb.', time: '', use: ''},
  {name: 'Citra', amount: 1, unit: 'oz.', time: '', use: 'First Wort'},
  {name: "Citra", amount: 1, unit: 'oz.', time: '15', use: 'Boil'},
  {name: 'Citra', amount: 1, unit: 'oz.', time: '10', use: 'Boil'},
  {name: 'Citra', amount: 1, unit: 'oz.', time: '5', use: 'Boil'},
  {name: 'Citra', amount: 1, unit: 'oz.', time: '1', use: 'Boil'},
  {name: 'Citra', amount: 3, unit: 'oz.', time: '10080', use: 'Dry Hop'},
  {name: 'Safale S-04', amount: 4, unit: 'pack', time: '', use: ''}
]
total = ingredient_list.count
ingredient_list.each_with_index do |ingredient, index|
  puts "#{index+1}/#{total} - #{ingredient[:name]}"
  RecipeIngredient.create(
    recipe_id: example_recipe2.id,
    ingredient_id: Ingredient.where(name: ingredient[:name]).first.id,
    amount: ingredient[:amount],
    unit_id: Unit.where(name: ingredient[:unit]).first.id,
    use_id: (ingredient[:use].blank? ? nil : Use.where(name: ingredient[:use]).first.id),
    time: ingredient[:time]
  )
end

puts "******- creating example recipe ratings"

Rating.create(
  user_id: rating_user.id,
  recipe_id: example_recipe.id,
  rating: 2,
  comment: "I don't think I'd make this one again, but I don't hate it either."
)

Rating.create(
  user_id: rating_user2.id,
  recipe_id: example_recipe.id,
  rating: 4
)

puts "******* creating example inventory"

inventory_list = [
  {name: 'Pale 2-Row', amount: 13.5, unit: 'lb.'},
  {name: 'Flaked Oats', amount: 2.25, unit: 'lb.'},
  {name: 'Chocolate', amount: 2, unit: 'lb.'},
  {name: 'Black Patent', amount: 6, unit: 'lb.'},
  {name: 'Roasted Barley', amount: 5, unit: 'lb.'},
  {name: 'Caramel / Crystal 15L', amount: 10, unit: 'lb.'},
  {name: "Carapils", amount: 5, unit: 'lb.'},
  {name: 'Willamette', amount: 4, unit: 'oz.'},
  {name: 'Cocoa Nibs', amount: 10, unit: 'oz.'},
  {name: 'San Diego Super Yeast', amount: 4, unit: 'pack'}
]
total = inventory_list.count
inventory_list.each_with_index do |inventory, index|
  puts "#{index+1}/#{total} - #{inventory[:name]}"
  Inventory.create(
    user_id: recipe_user.id,
    ingredient_id: Ingredient.where(name: inventory[:name]).first.id,
    amount: inventory[:amount],
    unit_id: Unit.where(name: inventory[:unit]).first.id
  )
end
