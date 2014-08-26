FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { "password" }
    password_confirmation { "password" }
    role { "pledger" }
  end

  # User with an empty pledge
  factory :user_with_pledge,
    :class => User,
    :parent => :user do
      role { "pledger" }
      pledges { [FactoryGirl.create(:pledge)]}
    end

  # User with an empty performance
  factory :user_with_performance,
    :class => User,
    :parent => :user do
      role { "performer" }
      performances { [FactoryGirl.create(:performance)] }
    end

  # User with a pledge and campaign
  factory :user_with_pledge_and_campaign,
    :class => User,
    :parent => :user do
      role { "pledger" }
      pledges { [FactoryGirl.create(:pledge_with_campaign)]}
    end

  # User with a performance and campaign
  factory :user_with_performance_and_campaign,
    :class => User,
    :parent => :user do
      role { "performer" }
      performances { [FactoryGirl.create(:performance_with_campaign)] }
    end

  factory :user_admin,
    :class => User,
    :parent => :user do
      role { "admin" }
    end
end