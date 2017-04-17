require 'spec_helper'

describe Category do
  it "has a valid factory" do
    expect(FactoryGirl.create(:category)).to be_valid
  end

  it {expect validate_presence_of(:name)}
end
