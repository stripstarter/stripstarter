FactoryGirl.define do
  factory :pledge do
    amount { 50 }
  end

  factory :pledge_with_user,
    :class => Pledge,
    :parent => :pledge do
      user { FactoryGirl.create(:user, role: 'pledger') }
    end

  factory :pledge_with_campaign,
    :class => Pledge,
    :parent => :pledge do
      campaign { FactoryGirl.create(:campaign) }
    end

  factory :pledge_with_campaign_and_user,
    :class => Pledge,
    :parent => :pledge do
      user { FactoryGirl.create(:user) }
      campaign { FactoryGirl.create(:campaign) }
    end
end