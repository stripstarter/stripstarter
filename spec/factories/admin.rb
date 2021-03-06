FactoryGirl.define do
  factory :admin do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { "test@example.com" }
    password { "password" }
    password_confirmation { "password" }
    type { "Admin" }
  end
end