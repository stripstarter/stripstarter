class Campaign < ActiveRecord::Base
  include CampaignStateMachine

  has_many :campaign_feature_joins
  has_many :features, through: :campaign_feature_joins

  # Fetch all associated pledgers
  has_many :pledges
  has_many :users, through: :pledges

  # Fetch all associated performers
  has_many :performances
  has_many :users, through: :performances

end
