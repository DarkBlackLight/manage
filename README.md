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
gem 'caxlsx', "~> 3.0.4"
gem 'caxlsx_rails', "~> 0.6.2"
gem 'manage', git: 'https://github.com/DarkBlackLight/manage'
gem 'manage-coreui', git: 'https://github.com/DarkBlackLight/manage-coreui'
gem 'font-awesome-sass', '~> 5.15.1'

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

//= link admin.js
//= link admin.css

```

Create file app/assets/javascripts/admin.js with following code

```ruby

//= require manage

```

Create file app/assets/stylesheets/admin.scss with following code

```ruby

@import "manage";

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

Create file app/helpers/admin_helper.rb with following code

```ruby

module AdminHelper
  def setup_config
    {
      scope: 'admin',
      title: 'CMS Admin System',
      sessions: {
        authentication_key: 'email',
        title: 'Welcome To CMS',
        description: 'This is a Description'
      }
    }
  end
end

```

Create file app/controllers/admin_controller.rb with following code

```ruby

class AdminController < ApplicationController

  before_action :authenticate_admin_user!
  # before_action :setup_user_view

  
  include AdminHelper
  include ManageControllerConcern

  def current_ability
    @current_ability ||= Ability::AdminAbility.new(current_admin_user)
  end
  
  # def setup_user_view
  #   setup_view(current_admin_user)
  # end

  def setup_routes
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

Create empty file app/views/admin/dashboard/index.html.erb with following code

```ruby
```

Create file app/controllers/admin/sessions_controller.rb with following code

```ruby

class Admin::SessionsController < Manage::SessionsController
  include AdminHelper
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

Use the following command to create the admn table

```bash
$ rails g model admin --force
```

Add this line to your db/migrate/YYYYMMDDHHMMSS_create_admins_rb

```ruby

      t.string :full_name
      t.integer :role
      
```

Add this line to your app/models/admin.rb

```ruby

  scope :query_name, -> (q) { where('lower(admins.full_name) like lower(?) ', "%#{q}%") }

  has_one :user, as: :source, dependent: :destroy
  accepts_nested_attributes_for :user
      
```

Create file app/controllers/admin/admins_controller.rb with following code


```ruby

 class Admin::AdminsController < Admin::ResourcesController

  private

  def filter_params
    params.slice(:query_name)
  end

  def resource_params
    params.require(:admin).permit(:full_name, :role, user_attributes: [:id, :first_name, :last_name, :email, :password, :password_confirmation])
  end

end
      
```

Add this line to your db/seeds.rb

```ruby

 ActiveRecord::Base.transaction do
  Admin.create!(role: :admin,
                user_attributes: { email: 'admin@name.com',
                                   password: '123456',
                                   first_name: 'admin',
                                   last_name: 'name', })

end
```

Create file app/models/user.rb with following code


```ruby
class User < ApplicationRecord

  devise :database_authenticatable, :rememberable

  belongs_to :source, polymorphic: true

  before_save :set_full_name
  after_save :set_source_full_name

  validates  :email, presence: true

  def set_full_name
    self.full_name = "#{first_name} #{last_name}"
  end

  def set_source_full_name
    if self.source.full_name != self.full_name
      self.source.update_attribute(:full_name, self.full_name)
    end
  end

end
      
```

Final execution：

```bash
$ rails db:create
$ rails db:migrate
$ rails db:seed
```
