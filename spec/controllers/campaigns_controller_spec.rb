require 'rails_helper'
require 'spec_helper'

describe CampaignsController do

  context "#index" do

    subject(:campaign) do
      FactoryGirl.create(:campaign, name: "First campaign")
    end

    it "responds with campaigns" do
      get :index, format: :json
      body = JSON.parse(response.body)["campaigns"]
      expect(body.size).to be > 0
    end
  end

  context "#show" do

    subject(:campaign) do
      FactoryGirl.create(:campaign, name: "First campaign")
    end

    it "responds with a particular campaign" do
      get :show, id: campaign.id, format: :json
      body = JSON.parse(response.body)["campaign"]
      expect(body["id"]).to eq(campaign.id)
    end
  end

  context "#edit/update" do

    subject(:campaign) do
      FactoryGirl.create(:campaign, name: "First campaign")
    end

    it "allows the owner to update the campaign" do
      controller.stub(:current_user).and_return(campaign.owner)
      get :edit, id: campaign.id, format: :html
      expect(response).to be_success
    end

    it "doesn't allow others to update the campaign" do
      controller.stub(:current_user).and_return(campaign.performers.first)
      get :edit, id: campaign.id, format: :html
      expect(response).to_not be_success
      expect(response).to redirect_to campaigns_path
    end
  end


  context "#create" do

    it "creates a campaign with name" do
      pledger = FactoryGirl.create(:pledger)
      controller.stub(:current_user).and_return(pledger)
      post :create, campaign: {name: "Example Campaign"}, format: :html
      expect(Campaign.last.name).to eq("Example Campaign")
    end

    it "cannot create a campaign with no owner" do
      controller.stub(:current_user).and_return(nil)
      post :create, campaign: {name: "Example Campaign"}, format: :html
      expect(response).to render_template("campaigns/new")
    end
  end

  context "#destroy" do

    subject(:campaign) do
      FactoryGirl.create(:campaign_with_performance, name: "First campaign")
    end

    it "allows an owner to delete a campaign" do
      controller.stub(:current_user).and_return(campaign.owner)
      delete :destroy, id: campaign.id
      expect(flash[:notice]).to eq Stripstarter::Response::CAMPAIGN_DESTROY_SUCCESS
      expect(response).to redirect_to campaigns_path
      campaign.reload
      expect(campaign.canceled?).to be_truthy
    end

    it "allows a performer to delete a campaign" do
      controller.stub(:current_user).and_return(campaign.performers.first)
      delete :destroy, id: campaign.id
      expect(flash[:notice]).to eq Stripstarter::Response::CAMPAIGN_DESTROY_SUCCESS
      expect(response).to redirect_to campaigns_path
      campaign.reload
      expect(campaign.canceled?).to be_truthy
    end
  end
end