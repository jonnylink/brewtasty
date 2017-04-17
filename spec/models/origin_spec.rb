require 'spec_helper'

describe Origin do
  it "has a valid factory" do
    expect(FactoryGirl.create(:origin)).to be_valid
  end

  it {expect validate_presence_of(:name)}
end
