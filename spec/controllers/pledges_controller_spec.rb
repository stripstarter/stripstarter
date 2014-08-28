require 'rails_helper'

RSpec.describe PledgesController, :type => :controller do

  context "#index" do
    it "lists all of a user's pledges" do
      user = FactoryGirl.create(:user_with_pledge)
      controller.stub(:current_user).and_return(user)
      pledge = user.pledges.first
      get :index, id: pledge.id, user_id: user.id, format: :html
      expect(response.status).to eq(200)
    end
  end

  context "#create" do
    it "creates a pledge" do
      user = FactoryGirl.create(:user)
      controller.stub(:current_user).and_return(user)
      campaign = FactoryGirl.create(:campaign)
      post  :create,
            pledge: {amount: 100, campaign_id: campaign.id},
            format: :html
      expect(response).to redirect_to user_path(user)
    end

    it "fails if user is performer" do
      user = FactoryGirl.create(:user, role: "performer")
      controller.stub(:current_user).and_return(user)
      campaign = FactoryGirl.create(:campaign)
      expect do
        post  :create,
              pledge: {amount: 100, campaign_id: campaign.id},
              format: :html
      end.to raise_error(Stripstarter::Error::UserMismatch)
    end
  end

end
