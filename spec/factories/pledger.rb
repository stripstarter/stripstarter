FactoryGirl.define do
  factory :pledger do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { "password" }
    password_confirmation { "password" }
    type { "Pledger" }
  end

  # Pledger with an empty pledge
  factory :pledger_with_pledge,
    :class => Pledger,
    :parent => :pledger do
      pledges { [FactoryGirl.create(:pledge)]}
    end

  # Pledger with a pledge and campaign
  factory :pledger_with_pledge_and_campaign,
    :class => Pledger,
    :parent => :pledger do
      pledges { [FactoryGirl.create(:pledge_with_campaign)]}
    end
end