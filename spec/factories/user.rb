FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "person#{n}@test_email.com"}
    sequence(:username) {|n| "person#{n}"}
    password "password"
    password_confirmation "password"
  end
end
