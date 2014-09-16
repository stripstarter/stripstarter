#
# Cookbook Name:: stripstarter
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

#####################
# Misc dependencies #
#####################
include_recipe "apt::default"
include_recipe "yum"
include_recipe 'openssl'

##############
# Postgresql #
##############
include_recipe 'postgresql'
include_recipe 'postgresql::server'
bash "assign-postgres-password" do
  user 'postgres'
  code <<-EOH
echo "CREATE DATABASE stripstarter_dev;" | psql -p #{node['postgresql']['config']['port']}
echo "ALTER DATABASE stripstarter_dev OWNER postgres;" | psql -p #{node['postgresql']['config']['port']}
  EOH
  action :run
end

###########
# Sqlite3 #
###########
package 'libsqlite3-dev' do
  action :install
end

########
# Ruby #
########
include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"
rbenv_ruby "2.1.2" do
  ruby_version "2.1.2"
  global "2.1.2"
end

####################
# Rubygems/Bundler #
####################
include_recipe 'rubygems'
bash 'bundler-and-bash-profile-misc' do
  code <<-EOH
echo "gem: --user-install" >> /home/vagrant/.gemrc
export PATH=/home/vagrant/.gem/ruby/2.1.0/bin:$PATH
echo "cd /var/www/stripstarter.org/current" >> /home/vagrant/.bash_profile
source /home/vagrant/.bash_profile
gem install bundler
sudo chmod g+w /var/www/stripstarter.org/current/.git/FETCH_HEAD
  EOH
end

#########
# Nginx #
#########
include_recipe 'nginx'
template "/etc/nginx/sites-enabled/stripstarter.org" do
  source "nginx.conf.erb"
  action :create
end

###############
# ImageMagick #
###############
include_recipe 'imagemagick'

#########
# Redis #
#########
package 'redis-server' do
  action :install
end
include_recipe 'redis'
package 'redis-tools'

########################
# Because God hates us #
########################
git "/home/vagrant/jazz_hands" do
  repository "git://github.com/stripstarter/jazz_hands.git"
  reference "master"
  action :sync
end
bash "loosen-permissions" do
  code <<-EOH
sudo chmod -R 777 /home/vagrant/jazz_hands
  EOH
end

###########
# Unicorn #
###########
template "/etc/init.d/unicorn" do
  source "unicorn.erb"
  mode "0755"
  action :create
  owner "vagrant"
end

#######
# SSH #
#######
template "/home/vagrant/.ssh/config" do
  source "ssh-config.erb"
  action :create
end

#####################
# Rest of the stuff #
#####################
bash "setup-the-app" do
  code <<-EOH
cd /var/www/stripstarter.org/current
export PATH=/home/vagrant/.gem/ruby/2.1.0/bin:$PATH
export PATH=/opt/rbenv/versions/2.1.2/bin:$PATH
bundle config disable_local_branch_check true
bundle config local.jazz_hands ~/jazz_hands
bundle install
bundle exec rake db:migrate
bundle exec rake db:seed
  EOH
end
