class CampaignObserver < ActiveRecord::Observer

  def after_approve(campaign, transition)
    pledges.find_each(&:charge!)
    # TODO: send out a mailer
  end

  def after_deny(campaign, transition)
    # TODO: send out a mailer
  end
end