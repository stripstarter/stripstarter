# Stripstarter

[![Build Status](https://travis-ci.org/stripstarter/stripstarter.png)](https://travis-ci.org/stripstarter/stripstarter)

## About

[Stripstarter](http://www.stripstarter.us) is a social crowdsourcing app.  The idea is that two types of people can make campaigns:

* individuals looking to raise money for production of material of which they own the creative license, and

* individuals pledging money to elicit production of material of which the target of the campaign owns the creative license

An example would be a crowd-sourced campaign for Barack Obama to take a series of photographs in a state of undress.  In our business plan, John Doe would create a campaign.  This campaign would receive additional pledges from interested users, driving the pledge amount up.  If, at any point, the President decides to accept the campaign, he would release the material to Stripstarter, who would distribute it to all who pledged to the campaign.

Alternatively, the President could start a campaign himself which, if it received a requisite funding level, would achieve the same effect.

When one creates a campaign, they specify certain features.  For example: a video of Mr. Obama with a shoe on his head.  Others can create campaigns for the same person with other features.  Therefore, there can be multiple co-existing campaigns for the same person.  To redeem a campaign, the person must release the specified medium (photo/video) including the features specified.  Distribution rights are held by Stripstarter.

For any additional information, please email stripstarter [at] gmail [dot] com.

All code in this repository is released under the [Do What The Fuck You Want license](http://www.wtfpl.net/)

## Build instructions

#### First install...

1.  Ruby 2.x.x

2.  Rails 4

3.  Postgres 9.x

4.  [Redis](http://redis.io)

5.  [Sidekiq](https://github.com/mperham/sidekiq) (optional)

6.  [Pow](http://pow.cx/) (optional)

#### And then...

1.  Fork this repo and `git clone` it on your machine.

2.  Install postgres with a database named 'stripstarter', a role named 'stripstarter', and a password of your choosing.

3.  Copy `config/database.yml.example` to `config/database.yml` and fill in the fields for at least development with the postgres password you chose.

4.  Copy `config/secrets.yml.example` to `config/secrets.yml` and fill it in with some secret keys (`rake secret` to get secrets, yo)

5.  `bundle install`

6. `bundle exec rake db:create`, `bundle exec rake db:migrate` and `bundle exec rake db:seed`

7.  Follow [pow's instructions](http://pow.cx/) if using Pow or just do `bundle exec rails s` in the app directory.

8.  Read the [wiki](http://github.com/stripstarter/stripstarter/wiki)!


## Best practices

1.  Push your changes to your fork; make a PR into the main repo; wait for someone else to code review and merge in.

2.  Two-space indentation on all files, please.

3.  Write tests for new code if you have a chance.


## Contributing

1.  Fork the repo into your own account

2.  Push branches to your repo and make PRs against the main repo's master branch

#### Anonymity

If you don't want to be publicly associated with this project but still want to contribute, send an email to stripstarter [at] gmail [dot] com with your public key so you can commit as the Stripstarter user.

See [the wiki page](https://github.com/stripstarter/stripstarter/wiki/Command-line-shortcuts) for a simple commit alias.

![License](http://www.wtfpl.net/wp-content/uploads/2012/12/wtfpl-badge-1.png)
