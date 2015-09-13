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

## Commands

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
```

## Tasks

https://trello.com/b/UoSGhf1y/clonnit

## User stories

[User stories][1]

1: docs/user-stories.md
