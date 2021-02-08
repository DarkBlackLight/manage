# frozen_string_literal: true

class Manage::SessionsController < Devise::SessionsController
  include ManageControllerConcern
end
