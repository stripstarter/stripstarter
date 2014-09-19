require 'rails_helper'

RSpec.describe Campaign, :type => :model do

  context "state machine" do

    before(:each) do
      @campaign = FactoryGirl.create(:campaign)
    end

    it "has an initial state of 'active'" do
      expect(@campaign.status).to eq('active')
    end

    it "responds to #inactive?" do
      expect(@campaign.active?).to be_truthy
    end

    it "transitions to canceled" do
      @campaign.cancel
      expect(@campaign.canceled?).to be_truthy
    end
  end

  context "associations" do

    before(:each) do
      @campaign = FactoryGirl.create(:campaign_with_pledge_and_performance)
    end

    it "has performers" do
      expect(@campaign.performers.first).to be_a Performer
    end

    it "has pledgers" do
      expect(@campaign.pledgers.first).to be_a Pledger
    end

    it "has both" do
      types = @campaign.users.map(&:class)
      expect(types).to include Performer
      expect(types).to include Pledger
    end
  end

  context "scopes" do

    before(:each) { Campaign.find_each(&:destroy) }
    it "#top" do
      campaign1 = FactoryGirl.create(:campaign_with_pledge)
      campaign2 = FactoryGirl.create(:campaign_with_pledge)
      campaign2.pledges << FactoryGirl.create(:pledge_with_pledger)
      ordered_campaigns = Campaign.top
      expect(ordered_campaigns.first).to eq(campaign2)
      expect(ordered_campaigns.last).to eq(campaign1)
    end

    it "#newest" do
      campaign1 = FactoryGirl.create(:campaign_with_pledge)
      sleep 0.1
      campaign2 = FactoryGirl.create(:campaign_with_pledge)
      newest_campaigns = Campaign.newest
      expect(newest_campaigns.first).to eq(campaign2)
      expect(newest_campaigns.last).to eq(campaign1)
    end
  end

end
