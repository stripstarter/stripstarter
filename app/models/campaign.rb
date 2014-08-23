class Campaign < ActiveRecord::Base
  include CampaignStateMachine

  has_many :campaign_feature_joins
  has_many :features, :through => :campaign_feature_joins


end
