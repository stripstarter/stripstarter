class Pledge < ActiveRecord::Base

	belongs_to :user
	belongs_to :campaign

  alias :pledger :user
end
