#
# Cookbook Name:: stripstarter
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

# bash "update apt-get" do
#   command "apt-get update"
#   command "sudo apt-get install redis redis-tools"
# end

# include_recipe "apt::default"
# include_recipe "yum"
# package 'redis'

# include_recipe 'rbenv'

# include_recipe 'ruby_build'
# ruby_build_ruby "2.1.2"
# rbenv_ruby "2.1.2"
# include_recipe 'rubygems'
# include_recipe 'postgresql'
# include_recipe 'postgresql::server'


# include_recipe 'nginx'
# include_recipe 'imagemagick'
# include_recipe 'redis'
# include_recipe 'god'
# include_recipe 'jekyll'

include_recipe "apache2"

apache_site "default" do
  enable true
end