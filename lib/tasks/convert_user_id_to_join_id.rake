require 'rake'

namespace :ss do
  task :convert_user_id_to_join_id => :environment do |t, args|
    Pledge.find_each do |pledge|
      pledge.pledger_id = pledge.user_id
      pledge.save
    end

    Performance.find_each do |performance|
      performance.performer_id = performance.user_id
      performance.save
    end
  end
end