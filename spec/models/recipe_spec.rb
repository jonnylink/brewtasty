require 'spec_helper'

describe Recipe do
  it "has a valid factory" do
    user = FactoryGirl.create(:user)
    expect(FactoryGirl.create(:recipe, user: user)).to be_valid
  end

  it { expect validate_presence_of(:user_id) }
  it { expect validate_presence_of(:name) }
  it { expect validate_uniqueness_of(:name) }
end
