require 'spec_helper'

describe Degree do
  it "has a valid factory" do
    expect(FactoryGirl.create(:degree)).to be_valid
  end

  it {expect validate_presence_of(:name)}
end
