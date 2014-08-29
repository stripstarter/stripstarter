FactoryGirl.define do
  factory :pledge do
    amount { 50 }
  end

  factory :pledge_with_pledger,
    :class => Pledge,
    :parent => :pledge do
      pledger { FactoryGirl.create(:pledger) }
    end

  factory :pledge_with_campaign,
    :class => Pledge,
    :parent => :pledge do
      campaign { FactoryGirl.create(:campaign) }
    end

  factory :pledge_with_campaign_and_pledger,
    :class => Pledge,
    :parent => :pledge do
      pledger { FactoryGirl.create(:pledger) }
      campaign { FactoryGirl.create(:campaign) }
    end
end