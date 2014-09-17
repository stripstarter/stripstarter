require "rails_helper"
require "set"

describe CheckoutController do
  render_views
  subject(:user) { FactoryGirl.create(:pledger_with_pledge_and_campaign) }

  context "#index" do

    it "shows all pending pledges" do
      controller.stub(:current_user).and_return(user)
      get :index, format: :json
      pledges = JSON.parse(response.body)
      expect(pledges.map { |p| p["id"] }.to_set).
        to eq(user.pledges.pending.map(&:id).to_set)
    end
  end

  context "#confirm_pledge" do
    it "changes pledge's state" do
      controller.stub(:current_user).and_return(user)
      post :confirm_pledge,
           pledge_id: user.pledges.pending.first.id,
           format: :json
      user.reload
      expect(user.pledges.pending.size).to eq(0)
      expect(user.pledges.active.size).to be > 0
    end
  end
end
