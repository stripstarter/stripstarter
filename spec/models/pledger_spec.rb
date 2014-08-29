require 'rails_helper'

RSpec.describe Pledger, :type => :model do
  context "associations" do

    before(:all) do
      @pledger = FactoryGirl.create(:pledger_with_pledge_and_campaign)
    end

    it "has campaigns through pledges" do
      expect(@pledger.campaigns.first).to be_a Campaign
    end

    it "has pledges" do
      expect(@pledger.pledges.first).to be_a Pledge
    end

    it "has no performances" do
      expect{@pledger.performances}.to raise_error(NoMethodError)
    end
  end
end