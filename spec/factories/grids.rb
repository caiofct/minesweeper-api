# This will guess the User class
FactoryBot.define do
  factory :grid do
    width 10
    height 10
    number_of_mines 10
    user
  end
end
