class Pledge < ActiveRecord::Base
  include Stripstarter::Error

	belongs_to :user
	belongs_to :campaign

  validate :user_is_a_pledger

  private

  def user_is_a_pledger
    if !user.pledger?
      errors.add(:user, "must be a pledger")
    end
  end

  alias :pledger :user
end
