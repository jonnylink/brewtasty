require 'spec_helper'

describe User do
  it {expect validate_presence_of(:username)}
  it {expect validate_presence_of(:email)}
  it {expect validate_uniqueness_of(:email)}
  it {expect validate_uniqueness_of(:username)}


  it "has a valid factory" do
    expect(FactoryGirl.create(:user)).to be_valid
  end

  it "returns true if a user has the inventory to brew a beer" do
    user = FactoryGirl.create(:user)
    unit = FactoryGirl.create(:unit)
    category = FactoryGirl.create(:category)
    ingredient = FactoryGirl.create(:ingredient, category: category)
    inventory = FactoryGirl.create(:inventory,
      user: user,
      ingredient: ingredient,
      unit: unit
    )
    recipe = FactoryGirl.create(:recipe, user: user)
    recipe_ingredient = FactoryGirl.create(:recipe_ingredient,
      recipe: recipe,
      ingredient: ingredient,
      unit: unit
    )
    expect(user.can_brew?(recipe)).to eq true
  end

  it "returns false if a user doesn't have the inventory to brew a beer" do
    user = FactoryGirl.create(:user)
    unit = FactoryGirl.create(:unit)
    category = FactoryGirl.create(:category)
    ingredient = FactoryGirl.create(:ingredient, category: category)
    recipe = FactoryGirl.create(:recipe, user: user)
    recipe_ingredient = FactoryGirl.create(:recipe_ingredient,
      recipe: recipe,
      ingredient: ingredient,
      unit: unit
    )
    expect(user.can_brew?(recipe)).to eq false
  end
end
