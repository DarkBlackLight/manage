module Manage
  class ManageController < ActionController::Base
    layout 'manage/application'

    before_action :authenticate_user!

  end
end
