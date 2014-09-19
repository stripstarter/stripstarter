class AdminController < ApplicationController
  before_filter :require_admin

  def campaigns
    @in_review = Campaign.in_review
    @completed = Campaign.completed
  end

  def approve
    @campaign = Campaign.find(params[:campaign_id])
    @campaign.approve!
    respond_to do |format|
      format.json { render nothing: true, status: 200 }
      format.html { redirect_to admin_campaigns_path }
    end
  end

  def deny
    @campaign = Campaign.find(params[:campaign_id])
    @campaign.deny!
    respond_to do |format|
      format.json { render nothing: true, status: 200 }
      format.html { redirect_to admin_campaigns_path }
    end
  end

  def cancel
    @campaign = Campaign.find(params[:campaign_id])
    @campaign.deny!
    respond_to do |format|
      format.json { render nothing: true, status: 200 }
      format.html { redirect_to admin_campaigns_path }
    end
  end


  private

  def require_admin
    redirect_to root_path unless current_admin?
  end
end