require 'spec_helper'

describe User do
  it "has a valid factory" do
    expect(FactoryGirl.create(:user)).to be_valid
  end

  it {expect validate_presence_of(:username)}
  it {expect validate_presence_of(:email)}
  it {expect validate_uniqueness_of(:email)}
  it {expect validate_uniqueness_of(:username)}
end
