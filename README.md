# Stripstarter

## About

[StripStarter](http://www.stripstarter.us) is a crowdfunding pornography app.  The idea is that two types of people can make campaigns:

* individuals looking to raise money for production of material of which they own the creative license, and

* individuals pledging money to elicit production of material of which the target of the campaign owns the creative license

An example would be a crowd-sourced campaign for Barack Obama to take a series of photographs in a state of undress.  In our business plan, John Doe would create a campaign.  This campaign would receive additional pledges from interested users, driving the pledge amount up.  If, at any point, the President decides to accept the campaign, he would release the material to Stripstarter, who would distribute it to all who pledged to the campaign.

Alternatively, the President could start a campaign himself which, if it received a requisite funding level, would achieve the same effect.

For any additional information, please email stripstarter [at] gmail [dot] com.

All code in this repository is released under the [Do What The Fuck You Want license](http://www.wtfpl.net/)

## Build instructions

* Ruby >= 2.0.0, Rails >= 4.0.0, Postgres >= 9.0

1.  Fork this repo and `git clone` it on your machine.

2.  Install postgres with a database named 'stripstarter', a role named 'stripstarter', and a password of your choosing.

3.  Copy `config/database.yml.example` to `config/database.yml` and fill in the fields for at least development with the postgres password you chose.

4.  Copy `config/secrets.yml.example` to `config/secrets.yml` and fill it in with some secret keys (`rake secret` to get secrets, yo)

5.  Generate an ssh key (preferably in `~/.ssh/id_rsa` or `~/.ssh/stripstarter`); email the public key to stripstarter [at] gmail [dot] com to get it put on the server.  If you put the key somewhere else, you'll need to update `config/deploy/production.rb` with the location for capistrano deployments.

6.  `rails s` in the main directory for the local server; `bundle exec cap deploy` to deploy the latest version of this repo to the server.


## Best practices

1.  Push your changes to your fork; make a PR into the main repo; wait for SOMEONE ELSE to code review and merge in.

2.  Two-space indentation on all files, please.

3.  Write tests for new code if you have a chance.
