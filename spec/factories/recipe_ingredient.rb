FactoryGirl.define do
  factory :recipe_ingredient do
    amount {rand(16)+1}
  end
end
