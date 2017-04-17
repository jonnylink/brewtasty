require 'spec_helper'

describe Kind do
  it "has a valid factory" do
    expect(FactoryGirl.create(:kind)).to be_valid
  end

  it {expect validate_presence_of(:name)}
end
