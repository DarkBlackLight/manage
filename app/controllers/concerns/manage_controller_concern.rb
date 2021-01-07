module ManageControllerConcern
  extend ActiveSupport::Concern
  include ManageHelper
  included do

    layout 'manage/application'
    before_action :setup_locale
    before_action :setup_config

    private

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

    def default_url_options
      { locale: I18n.locale }
    end

    def setup_config
      @title = "CMS System"
      @routes = []
    end

    def setup_view(current_user)
      UserView.create(user: current_user,
                      view_controller: controller_name,
                      view_action: action_id,
                      view_id: params[:id],
                      ip_address: request.remote_ip)
    end

  end
end
