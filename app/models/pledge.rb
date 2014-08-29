class Pledge < ActiveRecord::Base

	belongs_to :pledger
	belongs_to :campaign

end
