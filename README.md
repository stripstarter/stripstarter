# Stripstarter

[![Build Status](https://travis-ci.org/stripstarter/stripstarter.png)](https://travis-ci.org/stripstarter/stripstarter)

## About

[Stripstarter](http://www.stripstarter.us) is a [social crowdsourcing platform](http://blog.stripstarter.us/about/).

All code in this repository is released under the [Do What The Fuck You Want license](http://www.wtfpl.net/)

## Build instructions

You will need Ruby 2+, Rails 4, Postgres, [Redis](http://redis.io), and Imagemagick.  I recommend running [Pow](http://pow.cx/) as a web server, but any should work.

In postgres, create a database named 'stripstarter' and a role named 'stripstarter'; give it any password you want and make sure it has ownership of the database.

Fork and clone this repo.  Copy over your `secrets.yml.example` and `database.yml.example` to match your postgres configuration.

`bundle install`, `bundle exec rake db:setup`, and `bundle exec rails s` to get the app up and running.

Read the [wiki](http://github.com/stripstarter/stripstarter/wiki) for all sorts of information.


## Best practices

1.  Make pull requests against master and let Travis do his thing; let someone else code review

2.  Use the Github issue tracker to open and close issues.

3.  Write tests for all new features.

If you don't want to be publicly associated with this project but still want to contribute, send an email to stripstarter [at] gmail [dot] com with your public key so you can commit as the Stripstarter user.

See [this page](https://github.com/stripstarter/stripstarter/wiki/Command-line-shortcuts) for a simple commit alias.
