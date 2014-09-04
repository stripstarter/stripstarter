FactoryGirl.define do
  # Do not use this factory unless you really mean to
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { "password" }
    password_confirmation { "password" }
    avatar { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'test_avatar.png'), 'image/png') }
  end
end