FactoryGirl.define do
  factory :performer do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { "password" }
    password_confirmation { "password" }
    type { "Performer" }
  end

  # performer with an empty pledge
  factory :performer_with_performance,
    :class => Performer,
    :parent => :performer do
      performances { [FactoryGirl.create(:performance)]}
    end

  # performer with a performance and campaign
  factory :performer_with_performance_and_campaign,
    :class => Performer,
    :parent => :performer do
      performances { [FactoryGirl.create(:performance_with_campaign)]}
    end
end