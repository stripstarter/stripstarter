require "rails_helper"

describe PhotosController do
  context "#create" do
    subject(:campaign) do
      FactoryGirl.create(:campaign_with_performance)
    end

    it "photo for a performer" do
      performer = campaign.performers.first
      performance = Performance.find_by(
        performer_id: performer.id,
        campaign_id: campaign.id
      )
      expect(campaign.photos).to be_empty
      controller.stub(:current_user).and_return(performer)

      post :create, photo: {
        image: fixture_file_upload('test_avatar.png', 'image/png')
      }, campaign_id: campaign.id, format: :html

      expect(flash[:notice]).to eq(Stripstarter::Response::PHOTO_CREATE_SUCCESS)
      campaign.reload
      expect(campaign.photos).to_not be_empty
    end
  end
end