require 'spec_helper'

describe User do
  it {expect validate_presence_of(:username)}
  it {expect validate_presence_of(:email)}
  it {expect validate_uniqueness_of(:email)}
  it {expect validate_uniqueness_of(:username)}

  let!(:unit){ FactoryGirl.create(:unit) }
  let!(:category){ FactoryGirl.create(:category) }
  let!(:ingredient){ FactoryGirl.create(:ingredient, category: category) }

  it "has a valid factory" do
    expect(FactoryGirl.create(:user)).to be_valid
  end

  it "returns true if a user has the inventory to brew a beer" do
    user_has_everything = FactoryGirl.create(:user)
    inventory = FactoryGirl.create(:inventory,
      user: user_has_everything,
      ingredient: ingredient,
      unit: unit,
      amount: 20
    )
    recipe_1 = FactoryGirl.create(:recipe, user: user_has_everything)
    recipe_ingredient = FactoryGirl.create(:recipe_ingredient,
      recipe: recipe_1,
      ingredient: ingredient,
      unit: unit,
      amount: 10
    )
    expect(user_has_everything.can_brew?(recipe_1)).to eq true
  end

  it "returns false if a user doesn't have the inventory to brew a beer" do
    user_has_nothing = FactoryGirl.create(:user)
    recipe_2 = FactoryGirl.create(:recipe, user: user_has_nothing)
    recipe_ingredient = FactoryGirl.create(:recipe_ingredient,
      recipe: recipe_2,
      ingredient: ingredient,
      unit: unit
    )
    expect(user_has_nothing.can_brew?(recipe_2)).to eq false
  end

  it "returns false if a user doesn't have enough of the inventory to brew a beer" do
    user_has_some = FactoryGirl.create(:user)
    inventory = FactoryGirl.create(:inventory,
      user: user_has_some,
      ingredient: ingredient,
      unit: unit,
      amount: 2
    )
    recipe_3 = FactoryGirl.create(:recipe, user: user_has_some)
    recipe_ingredient = FactoryGirl.create(:recipe_ingredient,
      recipe: recipe_3,
      ingredient: ingredient,
      unit: unit,
      amount: 30
    )
    expect(user_has_some.can_brew?(recipe_3)).to eq false
  end
end
