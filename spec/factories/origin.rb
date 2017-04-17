FactoryGirl.define do
  factory :origin do
    sequence(:name){|n| "Great Place #{n}"}
  end
end
