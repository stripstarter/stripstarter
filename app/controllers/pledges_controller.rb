class PledgesController < ApplicationController

  before_filter :ensure_current_user_is_pledger
  before_filter :ensure_current_user, only: :index

  def new
    @pledge = Pledge.new
    @campaigns = Campaign.all
  end

  def create
    @pledge = Pledge.new(pledges_params)
    @pledge.user_id = current_user.id
    if @pledge.save
      redirect_to user_path(current_user)
    else
      render :action => 'new'
    end
  end

  def index
    @pledges = User.find(params[:user_id]).pledges
  end

  private

  def pledges_params
    params.require(:pledge).permit(:amount, :campaign_id)
  end

  def ensure_current_user_is_pledger
    raise Stripstarter::Error::UserMismatch unless current_user.pledger?
    true
  end

  def ensure_current_user
    if !(current_user && current_user.id == params[:user_id].to_i)
      raise Stripstarter::Error::Unauthorized
    end
    true
  end
end