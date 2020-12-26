module ManageControllerConcern
  extend ActiveSupport::Concern
  include ManageHelper
  included do

    layout 'manage/application'
    before_action :setup_title
    before_action :setup_routes

    private

    def setup_title
      @title = "CMS System"
    end

    def setup_routes
      @routes = []
    end

  end
end
