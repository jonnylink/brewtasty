require 'csv'

degrees = ['Low', 'Medium-Low', 'Medium', 'Medium-High', 'High', 'Very High', 'Variable']
degrees.each { |degree_name| Degree.create(name: degree_name) }

ingredient_categories = ['Fermentables', 'Hops', 'Yeasts', 'Others']
ingredient_categories.each { |ingredient_category| IngredientCategory.create(name: ingredient_category) }

ingredient_kinds = [
  'Acidulated malt (Grain)',
  'Base malt (Grain)',
  'Crystal malt (Grain)',
  'Dry',
  'Extract (Dry Extract)',
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
  'Raw (Adjunct)',
  'Roasted malt (Grain)',
  'Spice',
  'Water Agt'
]
ingredient_kinds.each { |ingredient_kind| IngredientKind.create(name: ingredient_kind) }

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
ingredient_uses.each { |ingredient_use| IngredientUse.create(name: ingredient_use) }

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
ingredients.each do |ingredient|
  the_ingredient = Ingredient.create(
    name: ingredient['name'],
    ingredient_category: (ingredient['category'].blank? ? '' : IngredientCategory.where(name: ingredient['category']).first.id),
    origin:  (ingredient['origin'].blank? ? '' : Origin.where(name: ingredient['origin']).first.id),
    kind: (ingredient['type'].blank? ? '' : IngredientType.where(name: ingredient['type']).first.id),
    use: (ingredient['use'].blank? ? '' : IngredientUse.where(name: ingredient['use']).first.id),
    alcohol_tolerance: (ingredient['alcohol_tolerance'].blank? ? '' : Degree.where(name: ingredient['alcohol_tolerance']).first.id),
    flocculation: (ingredient['flocculation'].blank? ? '' : Degree.where(name: ingredient['flocculation']).first.id),
    color: (ingredient['color'].blank? ? '' : ingredient['color']),
    ppg: (ingredient['ppg'].blank? ? '' : ingredient['ppg']),
    alpha: (ingredient['alpha'].blank? ? '' : ingredient['alpha']),
    product_id: (ingredient['product_id'].blank? ? '' : ingredient['product_id'])
  )
end

recipe_user = User.create(
  username: "jonlink",
  email: "jonlink@email.com",
  password: "testtest"
)

example_recipe = Recipe.create(
   user_id: recipe_user.id,
   name: "Russian Imperial Stout",
   original_gravity: 1.102,
   final_gravity: 1.023,
   alcohol_by_volume: 10.37,
   bitterness: 89.5,
   color: 62.25,
   boil_time: 90,
   batch_size: 5.5,
)

ingredient_list = [
  {name: 'Liquid Malt Extract - Light', amount: 3.3, unit: 'lb', time: ''},
  {name: 'Liquid Malt Extract - Munich', amount: 3.3, unit: 'lb', time: ''},
  {name: 'Liquid Malt Extract - Light', amount: 3.3, unit: 'lb', time: ''},
  {name: 'Chocolate', amount: 0.75, unit: 'lb', time: ''},
  {name: 'Roasted Barley', amount: 0.75, unit: 'lb', time: ''},
  {name: 'Caramel / Crystal 60L', amount: 1, unit: 'lb', time: ''},
  {name: 'Carapils (Dextrine Malt)', amount: 0.5, unit: 'lb', time: ''},
  {name: "Brewer's Gold", amount: 1, unit: 'oz', time: 60},
  {name: 'Willamette', amount: 0.2, unit: 'oz', time: 60},
  {name: 'Willamette', amount: 1.2, unit: 'oz', time: 10},
  {name: 'Willamette', amount: 0.5, unit: 'oz', time: 3},
  {name: 'California Ale Yeast', amount: '', unit: '', time: ''}
]
ingredient_list.each do |ingredient|
  RecipeIngredient.create(
    recipe_id: example_recipe.id,
    ingredient_id: Ingredient.where(name: ingredient[:name]).first.id,
    amount: ingredient[:amount],
    unit: ingredient[:unit],
    time: ingredient[:time]
  )
end

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
