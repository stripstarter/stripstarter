FactoryGirl.define do

  factory :campaign do
    name { Faker::Lorem.sentence }
    features { 2.times.collect { FactoryGirl.create(:feature) } }
  end

  factory :campaign_with_pledge,
    :class => Campaign,
    :parent => :campaign do
      pledges { [FactoryGirl.create(:pledge_with_pledger)] }
    end

  factory :campaign_with_performance,
    :class => Campaign,
    :parent => :campaign do
      performances { [FactoryGirl.create(:performance_with_performer)] }
    end

  factory :campaign_with_pledge_and_performance,
    :class => Campaign,
    :parent => :campaign do
      pledges { [FactoryGirl.create(:pledge_with_pledger)] }
      performances { [FactoryGirl.create(:performance_with_performer)] }
    end
end