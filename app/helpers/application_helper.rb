module ApplicationHelper
  def pending_pledges
    return "" if current_admin?
    pending_pledges = current_user.pledges.pending
    pending_pledges.blank? ? "" : " [ #{pending_pledges.count} ]"
  end

  def current_admin?
    current_user && current_user.is_a?(Admin)
  end
end