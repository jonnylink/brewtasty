RSpec.describe Recipe do
  it { expect validate_presence_of(:user_id) }
  it { expect validate_presence_of(:name) }
  it { expect validate_uniqueness_of(:name) }
end
