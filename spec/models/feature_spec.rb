require 'rails_helper'

RSpec.describe Feature, :type => :model do
  it "has campaigns" do
    @feature = FactoryGirl.create(:feature)
    expect{@feature.campaigns}.to_not raise_error
  end
end
