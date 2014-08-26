require "bundler/capistrano"
require "rvm/capistrano"

set :stages, %w(production staging)
set :default_stage, "production"

set :application, "stripstarter.us"

set :user, "deploy"
set :port, 1138
set :deploy_to, "/var/www/stripstarter.us"
# set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:stripstarter/stripstarter.git"
set :branch, "master"

set :current_path, "/var/www/stripstarter.us/current"
set :shared_path, "/var/www/stripstarter.us/shared"

set :deploy_config_path, `pwd` + "/config/deploy.rb"


default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_stripstarter.us #{command}"
    end
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{shared_path}/config/nginx.conf /etc/nginx/sites-enabled/stripstarter.us"
    sudo "ln -nfs #{shared_path}/config/unicorn_init.sh /etc/init.d/unicorn_stripstarter.us"
    run "mkdir -p /var/www/stripstarter.us/shared/config"
    puts "Now edit the config files in /var/www/stripstarter.us/shared."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs /var/www/stripstarter.us/shared/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs /var/www/stripstarter.us/shared/config/secrets.yml #{release_path}/config/secrets.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end