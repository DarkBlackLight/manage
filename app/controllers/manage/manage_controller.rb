module Manage
  class ManageController < ApplicationController
    layout 'manage/application'

    before_action :authenticate_user!

  end
end
