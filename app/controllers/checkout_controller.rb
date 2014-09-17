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
        customer = Stripe::Customer.create(
          :email => current_user.email,
          :card  => params[:stripeToken]
        )
        format.html { render action: 'index' }
        format.json { render nothing: true, status: 200 }
      rescue
        format.html { redirect_to root_path, flash: "Error" }
        format.json { render nothing: true, status: 500 }
      end
    end
  end

  def charge_pledge
    respond_to do |format|
      raise "No user" unless current_user
      @pledge = current_user.pledges.pending.find {|p| p.id == params[:pledge_id].to_i}
      raise "No pledge" unless @pledge

      begin
        charge = Stripe::Charge.create(
          :customer    => current_user.stripe_customer_id,
          :amount      => @pledge.amount.to_i, #to do: multiply by 100 or convert amount to cents in db
          :description => "#{@pledge.amount} for #{@pledge.campaign.name}",
          :currency    => 'usd'
        )
        @pledge.activate!
        format.html
        format.json { render nothing: true, status: 200 }
      rescue Stripe::CardError => e
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