module Manage
  class ManageController < ActionController::Base
    layout 'manage/application'

    before_action :authenticate_user!

    # def current_ability
    #   @current_ability ||= Ability.new(current_user)
    # end
  end
end
