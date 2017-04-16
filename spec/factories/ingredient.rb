FactoryGirl.define do
  factory :ingredient do
    sequence(:name) {|n| "ingredient #{n}"}
    category_id 1
  end
end
