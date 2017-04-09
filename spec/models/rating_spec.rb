RSpec.describe Rating, type: :model do
  it {expect validate_presence_of(:user_id)}
  it {expect validate_presence_of(:recipe_id)}
  it {expect validate_presence_of(:rating)}
end
