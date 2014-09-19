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
    it "should have a valid URL" do
      user = FactoryGirl.create(:user)
      expect(user.avatar.url).to_not match(/missing\.png/)
    end
    it "should give an amazon URL if s3 is configured" do
      if ENV['TEST_ENV'] != 'travis'
        setup_for_amazon!
        user = FactoryGirl.create(:user)
        expect(user.avatar.url).to match(/amazon/)
        teardown_from_amazon!
      end
    end
    it "should give a nil avatar a missing.png address" do
      user = FactoryGirl.create(:user)
      user.avatar = nil
      user.save
      expect(user.avatar.url).to match(/missing_original\.png/)
    end

    def setup_for_amazon!
      Paperclip::Attachment.default_options.merge!(
        :storage => :s3,
        :s3_permissions => :public_read,
        :s3_credentials => {
          :bucket => SS_CONFIG.amazon_bucket,
          :access_key_id => SS_CONFIG.amazon_access_key_id,
          :secret_access_key => SS_CONFIG.amazon_secret_access_key
        }
      )
    end
    def teardown_from_amazon!
      Paperclip::Attachment.default_options.merge!(:storage => :filesystem)
      Paperclip::Attachment.default_options.delete(:s3_credentials)
      Paperclip::Attachment.default_options.delete(:s3_permissions)
    end
  end
end
