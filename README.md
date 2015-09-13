## Commands

### Project creation

* rails new clonnit -d postgresql
* bin/bundle
* bundle exec spring binstub --all

### Initial devise setup

* bin/rails g devise:install
* bin/rails g devise user
* bin/rails g devise:views
* bin/rake db:create
* bin/rake db:migrate

### Annotate gem

* bin/rails g annotate:install
* bin/rake annotate_models

### Initial testing

* RAILS_ENV=test bin/rake db:create
* RAILS_ENV=test bin/rake db:migrate

### User registration

* bin/rails g integration_test user_registration
* bin/rails g migration add_username_to_users

### User session

* bin/rails g integration_test user_session

## Account recovering

* bin/rails g integration_test account_recovering

## Used devise modules

* Database Authenticatable
* Recoverable
* Registerable
* Rememberable
* Timeoutable
* Validatable

## Tasks

https://trello.com/b/UoSGhf1y/clonnit

## User stories

[User stories][1]

1: docs/user-stories.md
