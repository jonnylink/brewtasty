ingredients =
[
  {name: "Amber Dry Extract", category: "Dry Extract", amount: 6, unit: "lb"},
  {name: "Extra Light Dry Extract", category: "Dry Extract", amount: 1, unit: "lb"},
  {name: "Caramel/Crystal Malt", category: "Grain", amount: 0.5, unit: "lb"},
  {name: "Bullion [8.50 %]", category: "Hops", amount: 2, unit: "oz"},
  {name: "Hallertauer Hersbrucker [4.00 %]", category: "Hops", amount: 1, unit: "oz"},
  {name: "Irish Moss", category: "Fining", amount: 1, unit: "tsp"},
  {name: "Malto-Dextrine", category: "Additive", amount: 2, unit: "oz"},
  {name: "Edme Ale Yeast", category: "Yeast-Ale", amount: 1, unit: "pack"},
  {name: "Munton Fison Ale", category: "Yeast-Ale", amount: 1, unit: "pack"}
]

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

test_recipe = Recipe.create(
  user_id: recipe_user.id,
  name: "Awesome Amber"
)

ingredients.each do |ingredient|
  the_ingredient = Ingredient.create(name: ingredient[:name], category: ingredient[:category])
  RecipeIngredient.create(
    recipe_id: 1,
    ingredient_id: the_ingredient.id,
    amount: ingredient[:amount],
    unit: ingredient[:unit]
  )
end

Rating.create(
  user_id: rating_user.id,
  recipe_id: test_recipe.id,
  rating: 2,
  comment: "I don't think I'd make this one again, but I don't hate it either."
)

Rating.create(
  user_id: rating_user2.id,
  recipe_id: test_recipe.id,
  rating: 4
)
