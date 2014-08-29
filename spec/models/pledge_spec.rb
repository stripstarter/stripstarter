require 'rails_helper'

RSpec.describe Pledge, :type => :model do
  context "associations" do
    before(:each) do
      @pledge = FactoryGirl.create(:pledge_with_campaign_and_pledger)
    end

    it "has a campaign" do
      expect(@pledge.campaign).to be_a Campaign
    end

    it "has a pledger" do
      expect(@pledge.pledger).to be_a Pledger
    end
  end
end
