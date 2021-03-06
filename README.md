## Features

* A decent test suite
* Travis CI [![Build Status](https://travis-ci.org/sanrodari/clonnit.svg?branch=master)](https://travis-ci.org/sanrodari/clonnit)
* Use of Vagrant for consistent development environment provisioning [Vagrantfile](Vagrantfile), [provision.sh](provision.sh)
* Heroku deploy button [![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy?template=https://github.com/sanrodari/clonnit/tree/master)

## User stories

[User stories](docs/user-stories.md)

## Used devise modules

* Database Authenticatable
* Recoverable
* Registerable
* Rememberable
* Timeoutable
* Validatable

## Service orientation

* http://adamniedzielski.github.io/blog/2014/11/25/my-take-on-services-in-rails/
* https://blog.engineyard.com/2014/keeping-your-rails-controllers-dry-with-services
* https://github.com/gitlabhq/gitlabhq/tree/master/app/services

## Commands used to create this project

### Project creation

```bash
rails new clonnit -d postgresql
bin/bundle
bundle exec spring binstub --all
```

### Initial devise setup

```bash
bin/rails g devise:install
bin/rails g devise user
bin/rails g devise:views
bin/rake db:create
bin/rake db:migrate
```

### Annotate gem

```bash
bin/rails g annotate:install
bin/rake annotate_models
```

### Initial testing

```bash
RAILS_ENV=test bin/rake db:create
RAILS_ENV=test bin/rake db:migrate
```

### User registration

```bash
bin/rails g integration_test user_registration
bin/rails g migration add_username_to_users
```

### User session

```bash
bin/rails g integration_test user_session
```

### Account recovering

```bash
bin/rails g integration_test account_recovering
```

### Subclonnit creation

```bash
bin/rails g integration_test subclonnit_creation

# A base for the implementation, then rm all the cruft
bin/rails g scaffold subclonnit name description:text
bin/rails g model moderator user:belongs_to subclonnit:belongs_to
RAILS_ENV=test bin/rake db:migrate
bin/rails g migration add_unique_index_to_subclonnit_name
```

### Post creation

```bash
bin/rails g integration_test post_creation

# A base for the implementation, then rm all the cruft
bin/rails g scaffold post title url text:text user:belongs_to subclonnit:belongs_to
RAILS_ENV=test bin/rake db:migrate
bin/rails g migration add_not_null_title_to_posts
```

### Post voting

```bash
bin/rails g integration_test post_voting
bin/rails g model upvote post:belongs_to user:belongs_to
RAILS_ENV=test bin/rake db:migrate
bin/rails g model downvote post:belongs_to user:belongs_to
RAILS_ENV=test bin/rake db:migrate
```

### Add moderator

```bash
bin/rails g integration_test add_moderator
```

### Delete post

```bash
bin/rails g integration_test post_deletion
```

### Front page

```bash
bin/rails g integration_test front_page
bin/rails g controller frontpage show
bin/rails g migration add_default_to_subclonnit default:boolean
bin/rails g kaminari:config
bin/rails g kaminari:views default

bin/rails g model subscription user:belongs_to subclonnit:belongs_to
RAILS_ENV=test bin/rake db:migrate
bin/rails g devise:controllers users -c registrations
mkdir app/views/users
mv app/views/devise/registrations app/views/users
```

### Subclonnit subscription

```bash
bin/rails g integration_test subclonnit_subscription
```

## TODOs

* [ ] Improve frontpage list algorithm
* [ ] Sanitize post url from user input (To avoid xss, etc.)
* [ ] More test coverage
* [ ] Front end polishing
* [ ] Soft deleting for models
* [ ] Not to use id for urls, use something like https://github.com/norman/friendly_id or some custom solution
* [ ] Better tools integration: reek, flog, flay, rubycritic, possibly Code Climate or MetricFu, Simplecov
* [ ] Use activejob (and decide a backend for the jobs) for email sending and other jobs
* [ ] Refactor switch/if-elsif to using polymorphism/strategies
* [ ] Refactor constants to use freeze to enforce immutability
* [ ] Search for code/view duplications and refactor
* [ ] Narrow exception handling in services
* [ ] Add conventions, and CONTRIBUTING.md. Example https://github.com/gitlabhq/gitlabhq/blob/master/CONTRIBUTING.md
