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

Add this line to your app/assets/config/manifest.js

```ruby
// = link manage_manifest.js
```

Run command

```shell
rails generate devise:install
rails active_storage:install
rails manage:install:migrations
```

## Contributing

Contribution directions go here.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
