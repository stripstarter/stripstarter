class Feature < ActiveRecord::Base

  has_many :campaign_feature_joins
  has_many :campaigns, :through => :campaign_feature_joins

end
