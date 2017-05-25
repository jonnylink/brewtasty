require 'spec_helper'

describe Recipe do
  let!(:user){ FactoryGirl.create(:user) }
  let!(:beer){ FactoryGirl.create(:recipe, user: user) }
  let!(:hops){ FactoryGirl.create(:category, name: 'Hops') }
  let!(:fermentable){ FactoryGirl.create(:category, name: 'Fermentables') }
  let!(:hoppy_feet){ FactoryGirl.create(:ingredient, alpha: 10, category: hops) }
  let!(:malt_rats){ FactoryGirl.create(:ingredient, color: 80, category: fermentable) }
  let!(:oz){ FactoryGirl.create(:unit) }
  let!(:wort){ FactoryGirl.create(:use, name: 'First Wort') }
  let!(:recipe_ingredient1){ FactoryGirl.create(:recipe_ingredient,
    recipe: beer,
    ingredient: hoppy_feet,
    use: wort,
    amount: 3,
    unit: oz
  ) }
  let!(:lbs){ FactoryGirl.create(:unit, name: 'lbs.') }
  let!(:recipe_ingredient2){ FactoryGirl.create(:recipe_ingredient,
    recipe: beer,
    ingredient: malt_rats,
    amount: 5,
    unit: lbs
  ) }

  it "has a valid factory" do
    expect(beer).to be_valid
  end

  it { expect validate_presence_of(:user_id) }
  it { expect validate_presence_of(:name) }
  it { expect validate_uniqueness_of(:name) }

  it "calculates color" do
    expect(beer.color).to eq(28.23)
  end

  it "calculates ibu" do
    expect(beer.ibu).to eq(84.33)
  end

end
