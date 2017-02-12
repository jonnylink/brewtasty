FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "person#{n}@test_email.com"}
    username "person"
    password "password"
    password_confirmation "password"
  end
end
