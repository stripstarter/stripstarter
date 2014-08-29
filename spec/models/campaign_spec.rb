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

end
