require 'spec_helper'

describe Ingredient do
  it "has a valid factory" do
    category = FactoryGirl.create(:category)
    expect(FactoryGirl.create(:ingredient, category: category)).to be_valid
  end

  it {expect validate_presence_of(:name)}
  it {expect validate_presence_of(:category)}
end
