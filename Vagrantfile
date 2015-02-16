require 'berkshelf/vagrant'

# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
Vagrant.require_version ">= 1.5.0"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.omnibus.chef_version = :latest
  config.berkshelf.enabled = true
  config.vm.network "private_network", ip: "10.11.12.13"

  config.vm.synced_folder "~/Sites/stripstarter", "/var/www/stripstarter.org/current", type: "nfs"

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end

  # config.vm.box_check_update = false
  config.vm.network "forwarded_port", guest: 3000, host: 8081
  # config.ssh.private_key_path = "~/.ssh/id_rsa"
  config.ssh.forward_agent = true

  config.vm.provision "chef_solo" do |chef|
    chef.cookbooks_path = ["cookbooks", "~/.berkshelf/cookbooks"]
    chef.json = { 
      "postgresql" => {
        "password" => {
          "postgres" => "050a7eac113a490ae395bf8186c941c6" # MD5 hash of the production password; might replace with 'password' hashed
        },
        "config" => {
          "port" => 5432
        },
        "pg_hba" => [
          {:comment => '# Optional comment', :type => 'local', :db => 'all', :user => 'postgres', :addr => nil, :method => 'trust'}
        ]
      },
      "database" => {
        "create" => ["stripstarter_dev"]
      },
      "build_essential" => {
        "compile_time" => true
      },
      "nginx" => {
        "default_site_enabled" => false
      }
    }
    chef.run_list = [
      "recipe[stripstarter-cookbook::default]"
    ]
  end
end
