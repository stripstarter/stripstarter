require 'rails_helper'

RSpec.describe Performance, :type => :model do
  context "associations" do
    before(:each) do
      @performance = FactoryGirl.create(:performance_with_campaign_and_performer)
    end

    it "has a campaign" do
      expect(@performance.campaign).to be_a Campaign
    end

    it "has a performer" do
      expect(@performance.performer).to be_a Performer
    end
  end
end
