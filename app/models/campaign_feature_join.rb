class CampaignFeatureJoin < ActiveRecord::Base

  belongs_to :campaign
  belongs_to :feature
  
end
