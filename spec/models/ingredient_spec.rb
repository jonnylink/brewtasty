RSpec.describe Ingredient do
  it {expect validate_presence_of(:name)}
  it {expect validate_presence_of(:category)}
end
