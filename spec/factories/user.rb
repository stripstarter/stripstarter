FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { "password" }
    password_confirmation { "password" }
    role { "pledger" }
  end

  factory :user_performer, :class => User, parent: :user do
    role { "performer" }
  end
end