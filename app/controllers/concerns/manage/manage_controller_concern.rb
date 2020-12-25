module Manage
  module ManageControllerConcern
    extend ActiveSupport::Concern

    included do
      layout 'manage/application'

      before_action :_authenticate!
      helper_method :_current_user

      before_action :setup_routes

      private

      def _authenticate!
        warden.authenticate! scope: :user
      end

      def _current_user
        :current_user
      end

      def current_ability
        @current_ability ||= ManageAbility.new(current_user)
      end

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
end