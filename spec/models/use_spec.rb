require 'spec_helper'

describe Use do
  it "has a valid factory" do
    expect(FactoryGirl.create(:use)).to be_valid
  end

  it {expect validate_presence_of(:name)}
end
