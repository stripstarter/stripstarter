class Performance < ActiveRecord::Base

	belongs_to :user
	belongs_to :campaign

  alias :performer :user
end
