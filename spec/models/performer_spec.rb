require 'rails_helper'

RSpec.describe Performer, :type => :model do
  context "associations" do

    before(:all) do
      @performer = FactoryGirl.create(:performer_with_performance_and_campaign)
    end

    it "has campaigns through performances" do
      expect(@performer.campaigns.first).to be_a Campaign
    end

    it "has performances" do
      expect(@performer.performances.first).to be_a Performance
    end

    it "has no pledges" do
      expect{@performer.pledges}.to raise_error(NoMethodError)
    end
  end
end