require "rails_helper"

RSpec.describe Pledge, type: :model do
  subject(:pledge) { FactoryGirl.create(:pledge_with_campaign_and_pledger) }

  context "associations" do
    it "has a campaign" do
      expect(pledge.campaign).to be_a Campaign
    end

    it "has a pledger" do
      expect(pledge.pledger).to be_a Pledger
    end
  end

  context "transitions" do
    it "charges the user on #charge!" do
      expect(Stripe::Charge).to receive(:create)
      pledge.charge!
      expect(pledge.completed?).to be_truthy
    end
  end
end
