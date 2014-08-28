require 'rails_helper'

RSpec.describe User, :type => :model do
  context "creation" do
    it "able to create a user" do
      @user = FactoryGirl.create(:user)
    end
    it "catches a bad password" do
      expect do
        FactoryGirl.create(:user, password: "a", password_confirmation: "a")
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "catches password mismatch" do
      expect do
        FactoryGirl.create(:user, password: "password", password_confirmation: "passwordzzzzz")
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context "associations" do
    it "has pledges if a pledger" do
      @user = FactoryGirl.create(:user_with_pledge_and_campaign)
      expect do
        @user.pledges
      end.to_not raise_error
      expect(@user.pledges.first).to be_a Pledge
      expect(@user.campaigns.first).to be_a Campaign
    end

    it "has performances if a performer" do
      @user = FactoryGirl.create(:user_with_performance_and_campaign)
      expect do
        @user.performances
      end.to_not raise_error
      expect(@user.performances.first).to be_a Performance
      expect(@user.campaigns.first).to be_a Campaign
    end

    it "has no pledges if a performer" do
      @user = FactoryGirl.create(:user_with_performance_and_campaign)
      expect do
        @user.pledges
      end.to raise_error(Stripstarter::Error::UserMismatch)
    end

    it "has no performances if a pledger" do
      @user = FactoryGirl.create(:user_with_pledge_and_campaign)
      expect do
        @user.performances
      end.to raise_error(Stripstarter::Error::UserMismatch)
    end
  end
end
