require 'spec_helper'

describe RecipeIngredient do
  it "has a valid factory" do
    user = FactoryGirl.create(:user)
    unit = FactoryGirl.create(:unit)
    recipe = FactoryGirl.create(:recipe, user: user)
    category = FactoryGirl.create(:category)
    ingredient = FactoryGirl.create(:ingredient, category: category)
    recipe_ingredient = FactoryGirl.create(:recipe_ingredient,
      recipe: recipe,
      ingredient: ingredient,
      unit: unit
    )
    expect(recipe_ingredient).to be_valid
  end

  it {expect validate_presence_of(:recipe_id)}
  it {expect validate_presence_of(:ingredient_id)}
end
