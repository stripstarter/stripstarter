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
end
