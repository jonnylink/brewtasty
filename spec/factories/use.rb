FactoryGirl.define do
  factory :use do
    sequence(:name) {|n| "use #{n}"}
  end
end
