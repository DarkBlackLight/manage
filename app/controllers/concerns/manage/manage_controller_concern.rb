module Manage::ManageControllerConcern
  extend ActiveSupport::Concern
  included do
    layout 'controllers/application'

    before_action :authenticate_user!
    before_action :setup_routes

    private

    def setup_routes
      @routes = [{
                   name: "Dashboard",
                   url: url_for({ controller: :dashboard, action: :index }),
                   icon: "fas fa-tachometer-alt",
                   can: (can? :index, :dashboard)
                 }]
    end
  end
end
