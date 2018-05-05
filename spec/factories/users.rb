# This will guess the User class
FactoryBot.define do
  factory :user do
    name Faker::Name.name
    email Faker::Internet.email
    password "password"
  end
end
