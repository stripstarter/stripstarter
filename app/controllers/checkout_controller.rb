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
          flash[:notice] = "Success!"
          redirect_to checkout_path
        end
      rescue
        format.json { render nothing: true, status: 500 }
        format.html do
          flash[:notice] = "We could not add you at this time!"
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
        flash[:notice] = "Pledge successful, but you won't \
          be charged until the campaign completes."
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
      flash[:notice] = "We don't have a card for you on file! \
        Please add one by clicking the button below."
      redirect_to new_customer_path
    end
  end
end
