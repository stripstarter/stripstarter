# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'
require 'factory_girl'

10.times do
	FactoryGirl.create(:campaign)
end

10.times do
  FactoryGirl.create(:user)
end

5.times do
  FactoryGirl.create(:user_performer)
end
