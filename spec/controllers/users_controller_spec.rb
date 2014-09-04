require 'rails_helper'
require 'ostruct'

RSpec.describe UsersController, :type => :controller do

  subject(:user) do
    {
      first_name: "Test",
      last_name: "User",
      type: "Pledger",
      email: "test@example.com",
      password: "password",
      password_confirmation: "password",
      avatar: fixture_file_upload('test_avatar.png', 'image/png')
    }
  end


  context "#create" do
    subject(:created_user) { User.find_by email: user[:email] }

    before(:each) do
      post :create, user: user, format: :json
    end

    it "should create an account" do
      expect(created_user).to_not be_nil
    end

    it "should have an attachment" do
      expect(created_user.avatar.url).to_not match(/missing\.png/)
    end
  end
end
