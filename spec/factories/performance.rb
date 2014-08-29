FactoryGirl.define do
  factory :performance do
  end

  factory :performance_with_performer,
    :class => Performance,
    :parent => :performance do
      performer { FactoryGirl.create(:performer) }
    end

  factory :performance_with_campaign,
    :class => Performance,
    :parent => :performance do
      campaign { FactoryGirl.create(:campaign) }
    end

  factory :performance_with_campaign_and_performer,
    :class => Performance,
    :parent => :performance do
      performer { FactoryGirl.create(:performer) }
      campaign { FactoryGirl.create(:campaign) }
    end
end