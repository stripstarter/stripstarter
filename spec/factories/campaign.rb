FactoryGirl.define do

  factory :campaign do
    name { Faker::Lorem.sentence }
    features { 2.times.collect { FactoryGirl.create(:feature) } }
  end

  factory :campaign_with_pledger do
    pledges { [FactoryGirl.create(:pledge)] }
    performances { [FactoryGirl.create(:performance)] }
  end

  factory :campaign_with_users,
    :class => Campaign,
    :parent => :campaign do
      pledges { [FactoryGirl.create(:pledge_with_user)] }
      performances { [FactoryGirl.create(:performance_with_user)] }
    end
end