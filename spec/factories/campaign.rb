FactoryGirl.define do
  factory :campaign do
    name { Faker::Lorem.sentence }
    features { 2.times.collect { FactoryGirl.create(:feature) } }
  end
end