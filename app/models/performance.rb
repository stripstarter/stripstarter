class Performance < ActiveRecord::Base

	belongs_to :performer
	belongs_to :campaign

  has_many :photos

end
