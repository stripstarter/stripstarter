FactoryGirl.define do
  factory :feature do
    name { Faker::Lorem.words(2).join(" ") }
  end
end