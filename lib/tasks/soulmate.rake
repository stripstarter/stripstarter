require 'rake'

namespace :ss do
  namespace :soulmate do
    task :reset => :environment do |t, args|
      Soulmate.redis {|r| r.flushall }
      puts "Loading performers into soulmate..."
      Performer.find_each(&:load_into_soulmate)
      puts "Loading campaigns into soulmate..."
      Campaign.find_each(&:load_into_soulmate)
    end
  end
end