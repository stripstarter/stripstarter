require 'rails_helper'
require 'spec_helper'

describe CampaignsController do

	context "#index" do

		before(:each) do
			@campaign = FactoryGirl.create(:campaign, name: "First campaign")
		end

		it "responds with all campaigns" do
			get :index, format: :json
			body = JSON.parse(response.body)
			ids = body.collect {|node| node["id"]}
			expect(ids).to include(@campaign.id)
		end
	end

	context "#show" do

		before(:each) do
			@campaign = FactoryGirl.create(:campaign, name: "First campaign")
		end

		it "responds with a particular campaign" do
			get :show, id: @campaign.id, format: :json
			body = JSON.parse(response.body)
			expect(body["id"]).to eq(@campaign.id)
		end
	end
end