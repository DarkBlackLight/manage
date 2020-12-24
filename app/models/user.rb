class User < ApplicationRecord
  include Manage::UserConcern
end

