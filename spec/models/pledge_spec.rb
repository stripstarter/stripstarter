require 'rails_helper'

RSpec.describe Pledge, :type => :model do
  context "associations" do
    before(:each) do
      @pledge = FactoryGirl.create(:pledge_with_campaign_and_user)
    end

    it "has a campaign" do
      expect(@pledge.campaign).to be_a Campaign
    end

    it "has a pledger" do
      expect(@pledge.user).to be_a User
      expect(@pledge.user.role).to eq('pledger')
    end
  end

  context "validations" do
    it "fails if user is performer" do
      user = FactoryGirl.create(:user, role: 'perfomer')
      pledge = Pledge.new(user: user)
      expect(pledge).to_not be_valid
    end
  end
end
