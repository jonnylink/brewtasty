FactoryGirl.define do
  factory :degree do
    sequence(:name){|n| "level #{n}"}
  end
end
