require 'rails_helper'

RSpec.describe Performance, :type => :model do
  context "associations"
  before(:each) do
    @performance = FactoryGirl.create(:performance_with_campaign_and_user)
  end

  it "has a campaign" do
    expect(@performance.campaign).to be_a Campaign
  end

  it "has a performer" do
    expect(@performance.user).to be_a User
    expect(@performance.user.role).to eq('performer')
  end
end
