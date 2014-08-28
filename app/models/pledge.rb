class Pledge < ActiveRecord::Base

  # attr_accessible :user_id,
  #                 :campaign_id,
  #                 :amount

	belongs_to :user
	belongs_to :campaign

  alias :pledger :user
end
