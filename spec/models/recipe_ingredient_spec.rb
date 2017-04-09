RSpec.describe RecipeIngredient, type: :model do
  it {expect validate_presence_of(:recipe_id)}
  it {expect validate_presence_of(:ingredient_id)}
  it {expect validate_presence_of(:amount)}
  it {expect validate_presence_of(:unit)}
end
