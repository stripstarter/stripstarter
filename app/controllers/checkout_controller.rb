class CheckoutController < ApplicationController
  def index
    @pledges = current_user.try(:pledges).try(:pending) || []
    respond_to do |format|
      format.html
      format.json { render json: @pledges.to_json }
    end
  end

  def create_customer
    respond_to do |format|
      begin
        Stripe::Customer.create(
          email: current_user.email,
          card: params[:stripeToken]
        )
        format.html { render action: "index" }
        format.json { render nothing: true, status: 200 }
      rescue
        format.html { redirect_to root_path, flash: "Error" }
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
          amount:      @pledge.amount.to_i, 
          # TODO: multiply by 100 if amount is in dollars
          description: "#{@pledge.amount} for #{@pledge.campaign.name}",
          currency:    "usd"
        )
        @pledge.activate!
        format.html
        format.json { render nothing: true, status: 200 }
      rescue Stripe::CardError
        @pledge.decline
        format.html { redirect_to user_path(current_user), flash: "Error" }
        format.json { render nothing: true, status: 500 }
      end
    end
  end

  private

  def pledge_params
    params.require(:pledge).permit(:amount, :campaign_id)
  end
end
