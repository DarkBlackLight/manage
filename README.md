# Manage

Short description and motivation.

## Usage

How to use my plugin.

## Installation

Add those lines to your application's Gemfile:

```ruby
gem 'devise'
gem 'cancancan'
gem 'cocoon'
gem 'kaminari'
gem 'rails_sortable'
gem 'manage', git: 'https://github.com/liwuqi95/manage'
```

And then execute:

```bash
$ bundle
```

We need to determine a namespace in your application. We will use "Admin" as an example

## Configuration

Run command

```shell
rails generate devise:install
rails active_storage:install
rails manage_engine:install:migrations
```

Add this line to your app/assets/config/manifest.js

```ruby
// = link manage_manifest.js
```

Create file app/models/ability/admin_ability.rb with following code
```ruby
class Ability::AdminAbility
  include CanCan::Ability

  def initialize(user)
    can :manage, :all
  end
end

```

Create file app/controllers/admin_controller.rb with following code

```ruby
class AdminController < ApplicationController
  include ManageControllerConcern
  before_action :authenticate_admin_user!

  def current_ability
    @current_ability ||= Ability::AdminAbility.new(current_admin_user)
  end

  def setup_config
    @title = "Title For your App"
    @reoutes = []
  end
end
```

Add this line to your app/config/routes.rb inside routes

```ruby
  namespace :admin do
    devise_for :users
  end
```

## Contributing

Contribution directions go here.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
