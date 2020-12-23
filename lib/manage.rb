require "manage/version"
require "manage/engine"

module Manage
  # Your code goes here...
  #
  config.autoload_paths += Dir["#{Mygem::Engine.root}concerns/"]
end
