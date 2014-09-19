# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'
require 'factory_girl'

require Rails.root.join('spec/factories')

puts "Creating 100 campaigns with pledgers and performers"
100.times do
	FactoryGirl.create(:campaign_with_pledge_and_performance, status: "active")
end

FactoryGirl.create(:admin)
