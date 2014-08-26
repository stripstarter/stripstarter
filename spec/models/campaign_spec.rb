require 'rails_helper'

RSpec.describe Campaign, :type => :model do

  context "state machine" do

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

  context "associations" do

    before(:each) do
      @campaign = FactoryGirl.create(:campaign_with_users)
    end

    it "has performers" do
      expect(@campaign.performers.map(&:role).uniq).to eq(['performer'])
    end

    it "has pledgers" do
      expect(@campaign.pledgers.map(&:role).uniq).to eq(['pledger'])
    end

    it "has both" do
      expect(@campaign.users.count).to eq(2)
    end
  end

end
