class Feature < ActiveRecord::Base

  attr_accessor :name

  has_many :campaign_feature_joins
  has_many :campaigns, :through => :campaign_feature_joins

end
