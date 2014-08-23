class CampaignFeatureJoin < ActiveRecord::Base

	attr_accessor :campaign,
								:feature

	belongs_to :campaign
	belongs_to :feature
	
end
