module ApplicationHelper
  def pending_pledges
    pending_pledges = current_user.pledges.pending
    pending_pledges.blank? ? "" : " [ #{pending_pledges.count} ]"
  end
end