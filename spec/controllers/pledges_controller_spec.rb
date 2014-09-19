require 'rails_helper'

RSpec.describe PledgesController, :type => :controller do

  context "#index" do
    it "lists all of a pledger's pledges" do
      pledger = FactoryGirl.create(:pledger_with_pledge)
      controller.stub(:current_user).and_return(pledger)
      pledge = pledger.pledges.first
      get :index, user_id: pledger.id, format: :html
      expect(response.status).to eq(200)
    end

    it "lists pledgers pledges if user is admin" do
      admin = FactoryGirl.create(:admin)
      controller.stub(:current_user).and_return(admin)
      pledger = FactoryGirl.create(:pledger_with_pledge)
      get :index, user_id: pledger.id, format: :json
      pledges = JSON.parse(response.body)["pledges"]
      ids = pledges.map {|p| p["id"]}
      expect(ids).to include(pledger.pledges.first.id)
    end
  end

  context "#create" do
    it "creates a pledge via HTML" do
      pledger = FactoryGirl.create(:pledger)
      controller.stub(:current_user).and_return(pledger)
      campaign = FactoryGirl.create(:campaign)
      post :create,
           pledge: { amount: 100, campaign_id: campaign.id },
           format: :html
      expect(response).to redirect_to campaigns_path
    end

    it "creates a pledge via JSON" do
      pledger = FactoryGirl.create(:pledger)
      controller.stub(:current_user).and_return(pledger)
      campaign = FactoryGirl.create(:campaign)
      post :create,
           pledge: { amount: 100, campaign_id: campaign.id },
           format: :json
      pledge = JSON.parse(response.body)
      expect(pledge["status"]).to eq("pending")
    end

    it "fails if current_user is performer" do
      performer = FactoryGirl.create(:performer)
      controller.stub(:current_user).and_return(performer)
      campaign = FactoryGirl.create(:campaign)
      post :create,
           pledge: { amount: 100, campaign_id: campaign.id },
           format: :html
      expect(response).to redirect_to campaigns_path
    end
  end

end
