FactoryGirl.define do
  factory :kind do
    sequence(:name){|n| "kind #{n}"}
  end
end
