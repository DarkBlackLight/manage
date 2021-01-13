# Manage

Short description and motivation.

## Usage

How to use my plugin.

## Installation

Add those lines to your application's Gemfile:

```ruby
gem 'devise', "~> 4.7.3"
gem 'cancancan', "~> 3.2.0"
gem 'cocoon', "~> 1.2.15"
gem 'kaminari', "~> 1.2.1"
gem 'rails_sortable', "~> 1.4.1"
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
    @routes = [
      {
        name: "Dashboard",
        url: url_for({ controller: :dashboard, action: :index }),
        icon: "fas fa-tachometer-alt",
        can: (can? :index, :dashboard)
      }
    ]
  end
end
```

Create file app/controllers/admin/resources_controller.rb with following code

```ruby

class Admin::ResourcesController < ApplicationController
  include ManageResourcesConcern
end
```

Create file app/controllers/admin/dashboard_controller.rb with following code

```ruby

class Admin::DashboardController < AdminController
  def index
  end

  private
end

```

Create empty file app/controllers/views/admin/dashboard/index.html.erb with following code

```ruby
```

Create file app/controllers/admin/sessions_controller.rb with following code

```ruby

class Admin::SessionsController < Manage::SessionsController
  layout 'manage/application'
end

```

Add this line to your app/config/routes.rb inside routes

```ruby
namespace :admin do
  devise_for :users

  get 'dashboard/index'
  root 'dashboard#index'
end
```

Add this line to your app/models/application_record.rb inside ApplicationRecord

```ruby
  include Filterable
```

## Deployment with Docker

```shell
bundle lock --add-platform x86-mingw32 x86-mswin32 x64-mingw32 java
bundle package --all-platforms
```

## Remove bootsnap

remove this line in config/boot.rb

```ruby
require "bootsnap/setup"
```

remove this line in gemfile

```ruby
gem 'bootsnap', '>= 1.4.4', require: false
```

## Remove webpack

```shell
rm bin/webpack.rb
rm config/webpacker.yml
rm config/webpack
rm -rf app/javascripts
```
remove config.webpacker.check_yarn_integrity = false from config/{development, test, production}.rb
remove webpack from gemfile

## Contributing

Contribution directions go here.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
