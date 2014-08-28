class PledgesController < ApplicationController
  def new
    @pledge = Pledge.new
    @campaigns = Campaign.all
    if params[:user_id].to_i != current_user.id
      render :text => "You are not authorized", :status => 206
    end
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
end