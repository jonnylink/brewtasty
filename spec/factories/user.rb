FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "person#{n}@email.com"}
    sequence(:username) {|i| "person#{i}"}
    password "password"
    password_confirmation "password"
  end
end
