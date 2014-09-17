class CheckoutController < ApplicationController

  before_filter :ensure_stripe_customer_id, only: :charge_pledge

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
        customer = Stripe::Customer.create(
          email: params[:stripeEmail],
          card: params[:stripeToken]
        )
        current_user.stripe_customer_id = customer.id
        current_user.save
        format.html do
          flash[:notice] = "Success!"
          redirect_to checkout_path
        end
        format.json { render nothing: true, status: 200 }
      rescue
        format.html do
          flash[:notice] = "We could not add you at this time!"
          redirect_to root_path
        end
        format.json { render nothing: true, status: 500 }
      end
    end
  end

  def charge_pledge
    respond_to do |format|
      raise Stripstarter::Error::NoUser unless current_user
      @pledge = current_user.pledges.pending.detect do |pledge|
        pledge.id == params[:pledge_id].to_i
      end
      raise Stripstarter::Error::NoPledge unless @pledge

      begin
        Stripe::Charge.create(
          customer:    current_user.stripe_customer_id,
          amount:      @pledge.amount.to_i * 100, 
          description: "#{@pledge.amount} for #{@pledge.campaign.name}",
          currency:    "usd"
        )
        @pledge.activate!
        format.html do
          flash[:notice] = "Pledge successful!"
          redirect_to checkout_path
        end
        format.json { render nothing: true, status: 200 }
      rescue Stripe::CardError
        @pledge.decline
        format.html do
          flash[:notice] = "Your card was declined!"
          redirect_to checkout_path
        end
        format.json { render nothing: true, status: 500 }
      end
    end
  end

  private

  def pledge_params
    params.require(:pledge).permit(:amount, :campaign_id)
  end

  def ensure_stripe_customer_id
    if current_user.try(:stripe_customer_id).nil?
      flash[:notice] = "We don't have a card for you on file!  Please add one by clicking the button below."
      redirect_to new_customer_path 
    end
  end
end
