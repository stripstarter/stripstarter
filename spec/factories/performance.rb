FactoryGirl.define do
  factory :performance do
  end

  factory :performance_with_user,
    :class => Performance,
    :parent => :performance do
      user { FactoryGirl.create(:user, role: 'performer') }
    end

  factory :performance_with_campaign,
    :class => Performance,
    :parent => :performance do
      campaign { FactoryGirl.create(:campaign) }
    end

  factory :performance_with_campaign_and_user,
    :class => Performance,
    :parent => :performance do
      user { FactoryGirl.create(:user, role: 'performer') }
      campaign { FactoryGirl.create(:campaign) }
    end
end