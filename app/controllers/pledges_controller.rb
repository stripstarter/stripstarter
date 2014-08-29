class PledgesController < ApplicationController

  before_filter :ensure_pledger_or_admin

  def new
    @pledge = Pledge.new
    @campaigns = Campaign.all
  end

  def create
    @pledge = Pledge.new(pledges_params)
    @pledge.pledger_id = current_user.id
    if @pledge.save
      redirect_to user_path(current_user)
    else
      render :action => 'new'
    end
  end

  # Admin can see all; otherwise, just show your pledges
  def index
    @pledges = if current_admin?
      User.find(params[:user_id]).pledges
    else
      current_user.pledges
    end
    respond_to do |format|
      format.html
      format.json { render json: @pledges }
    end
  end

  private

  def pledges_params
    params.require(:pledge).permit(:amount, :campaign_id)
  end

  def ensure_pledger_or_admin
    if !(current_user.is_a?(Pledger) || current_admin?)
      raise Stripstarter::Error::Unauthorized
    else
      true
    end
  end
end