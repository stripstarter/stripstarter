require 'rails_helper'

RSpec.describe Feature, :type => :model do
  it "has campaigns" do
    Feature.find_each(&:destroy)
    Campaign.find_each(&:destroy)
    c = FactoryGirl.create(:campaign)
    # binding.pry
    expect(Feature.last.campaigns.first).to eq(c)
  end
end
