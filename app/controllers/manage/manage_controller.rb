module Manage
  class ManageController < ApplicationController
    include Manage::Concerns::Controllers::Article
  end
end
