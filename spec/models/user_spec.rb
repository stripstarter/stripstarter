require 'rails_helper'

RSpec.describe User, :type => :model do
  context "creation" do
    it "able to create a user" do
      user = FactoryGirl.create(:user)
      expect(user).to be_valid
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

  context "paperclip" do
    context "shoulda matchers" do
      it { should have_attached_file(:avatar) }
      it { should validate_attachment_content_type(:avatar).
                    allowing('image/png', 'image/gif').
                    rejecting('text/plain', 'text/xml') }
      it { should validate_attachment_size(:avatar).
                  less_than(2.megabytes) }
    end
  end
end
