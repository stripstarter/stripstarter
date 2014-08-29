require 'rake'

namespace :ss do
  task :convert_role_to_type => :environment do |t, args|
    User.find_each do |user|
      if user.respond_to?(:role) && user.role
        puts "User #{user.id}: setting type to #{user.role}..."
        user.type = user.role.capitalize
        user.save
      end
    end
  end
end