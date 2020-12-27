module ManageControllerConcern
  extend ActiveSupport::Concern
  include ManageHelper
  included do

    layout 'manage/application'
    before_action :setup_config

    private

    def setup_config
      @title = "CMS System"
      @routes = []
    end

  end
end
