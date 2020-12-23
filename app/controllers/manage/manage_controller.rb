module Manage
  class ManageController < ActionController::Base
    before_action :authenticate_manage_user!

    def current_ability
      @current_ability ||= Ability.new(current_manage_user)
    end
  end
end
