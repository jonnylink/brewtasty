RSpec.describe User, type: :model do
  it {expect validate_presence_of(:username)}
  it {expect validate_presence_of(:email)}
  it {expect validate_uniqueness_of(:email)}
  it {expect validate_uniqueness_of(:username)}
end
