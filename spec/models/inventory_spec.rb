require 'spec_helper'

describe Inventory do
  it "has a valid factory" do
    user = FactoryGirl.create(:user)
    unit = FactoryGirl.create(:unit)
    category = FactoryGirl.create(:category)
    ingredient = FactoryGirl.create(:ingredient, category: category)
    inventory = FactoryGirl.create(:inventory,
      user: user,
      ingredient: ingredient,
      unit: unit
    )
    expect(inventory).to be_valid
  end

  it {expect validate_presence_of(:user_id)}
  it {expect validate_presence_of(:product_id)}
  it {expect validate_presence_of(:amount)}
  it {expect validate_presence_of(:unit_id)}
end
