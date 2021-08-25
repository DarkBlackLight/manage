require_relative "lib/manage/version"

Gem::Specification.new do |spec|
  spec.name = "manage"
  spec.version = Manage::VERSION
  spec.authors = ["liwuqi95"]
  spec.email = ["wuqi.li@mail.utoronto.ca"]
  spec.homepage = "https://github.com/liwuqi95/manage"
  spec.summary = "Gem For CMS Management"
  spec.description = "Gem For CMS Management"
  spec.license = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "http://mygemserver.com"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", ">= 6.0.0"
  spec.add_dependency "devise", "~> 4.7.3"
  spec.add_dependency "cocoon", "~> 1.2.15"
  spec.add_dependency "cancancan", "~> 3.2.0"
  spec.add_dependency "kaminari", "~> 1.2.1"
  spec.add_dependency "rails_sortable", "~> 1.4.1"
  spec.add_dependency "roo", "~> 2.8.3"

end
