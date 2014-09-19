FactoryGirl.define do
  factory :photo do
    performance { FactoryGirl.create(:performance_with_campaign_and_performer) }
    image { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'test_avatar.png'), 'image/png') }
  end
end