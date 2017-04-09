RSpec.describe Ingredient, type: :model do
  it {expect validate_presence_of(:name)}
  it {expect validate_presence_of(:category)}
end
