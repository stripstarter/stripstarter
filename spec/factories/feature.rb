FactoryGirl.define do
  factory :feature do
    name { Faker::Company.catch_phrase }
  end
end