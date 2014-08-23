require 'rails_helper'

RSpec.describe Campaign, :type => :model do

  context "StateMachine" do

    before(:each) do
      @campaign = FactoryGirl.create(:campaign)
    end

    it "has an initial state of 'inactive'" do
      expect(@campaign.status).to eq('inactive')
    end

    it "responds to #inactive?" do
      expect(@campaign.inactive?).to be_truthy
    end

    it "transitions to active" do
      @campaign.activate
      expect(@campaign.active?).to be_truthy
    end
  end

end
