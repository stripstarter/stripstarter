class Campaign < ActiveRecord::Base

  has_many :campaign_feature_joins
  has_many :features, :through => :campaign_feature_joins

  # c = Campaign.last
  # c.features << Feature.last

end
