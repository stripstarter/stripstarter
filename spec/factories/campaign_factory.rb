FactoryGirl.define do
  factory :campaign do
    name { Faker::Lorem.sentence }
  end
end