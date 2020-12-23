module Manage
  class ManageController < ApplicationController
    layout 'manage/application'

    before_action :authenticate_user!
    before_action :setup_routes

    private

    def setup_routes
      @routes = [{
                   name: "Dashboard",
                   url: url_for({ controller: :dashboard, action: :index }),
                   icon: "cil-calendar",
                   can: (can? :index, :dashboard)
                 }]
    end

  end
end
