class CheckoutController < ApplicationController
  before_filter :ensure_stripe_customer_id, only: :confirm_pledge

  def index
    @pledges = current_user.try(:pledges).try(:pending) || []
    respond_to do |format|
      format.html
      format.json { render json: @pledges.to_json }
    end
  end

  def new_customer
  end

  def create_customer
    respond_to do |format|
      begin
        current_user.stripe_customer_id = 
          Stripe::Customer.create(
            email: params[:stripeEmail],
            card: params[:stripeToken]
          ).id
        current_user.save
        format.json { render nothing: true, status: 200 }
        format.html do
          flash[:notice] = Stripstarter::Response::CUSTOMER_CREATE_SUCCESS
          redirect_to checkout_path
        end
      rescue
        format.json { render json: current_user.errors, status: :unprocessable_entity }
        format.html do
          flash[:notice] = Stripstarter::Response::CUSTOMER_CREATE_FAILURE
          redirect_to root_path
        end
      end
    end
  end

  def confirm_pledge
    respond_to do |format|
      raise Stripstarter::Error::NoUser unless current_user
      @pledge = current_user.pledges.pending.detect do |pledge|
        pledge.id == params[:pledge_id].to_i
      end
      raise Stripstarter::Error::NoPledge unless @pledge

      @pledge.activate!
      format.json { render nothing: true, status: 200 }      
      format.html do
        flash[:notice] = Stripstarter::Response::PLEDGE_CONFIRM_SUCCESS
        redirect_to checkout_path
      end
    end
  end

  private

  def pledge_params
    params.require(:pledge).permit(:amount, :campaign_id)
  end

  def ensure_stripe_customer_id
    if current_user.try(:stripe_customer_id).nil?
      flash[:notice] = Stripstarter::Response::NOT_A_CUSTOMER
      redirect_to new_customer_path
    end
  end
end
