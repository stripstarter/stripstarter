class PledgesController < ApplicationController
  before_filter :ensure_pledger_or_admin
  before_filter :ensure_owner, only: :destroy

  def create
    @pledge = Pledge.new(pledges_params.merge pledger_id: current_user.id)
    if @pledge.save
      respond_to do |format|
        format.html { redirect_to user_path(current_user) }
        format.json { render json: @pledge.to_json }
      end
    else
      respond_to do |format|
        format.html { render action: "new" }
        format.json { render nothing: true, status: 500 }
      end
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

  def destroy
    @pledge ||= Pledge.find(params[:id])
    respond_to do |format|
      if @pledge.destroy
        format.json { render nothing: true, status: 200 }
        format.html do
          flash[:notice] = "Pledge deleted!"
          redirect_to checkout_path
        end
      else
        format.json { render nothing:true, status: 500 }
        format.html do
          flash[:notice] = "Pledge could not be deleted: \
            #{@pledge.errors.join}"
          redirect_to checkout_path
        end
      end
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

  def ensure_owner
    @pledge = Pledge.find(params[:id])
    if current_user != @pledge.pledger
      flash[:notice] = "You are not authorized to perform that action"
      redirect_to root_path
    end
  end
end