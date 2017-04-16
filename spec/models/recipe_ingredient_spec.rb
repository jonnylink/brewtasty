RSpec.describe RecipeIngredient do
  it {expect validate_presence_of(:recipe_id)}
  it {expect validate_presence_of(:ingredient_id)}
end
