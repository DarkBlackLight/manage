module ManageControllerConcern
  extend ActiveSupport::Concern
  include ManageHelper

  included do
    layout 'manage/application'
    before_action :setup_manage_config
    before_action :setup_locale
    before_action :setup_routes
    before_action :setup_user_view

    private

    def default_url_options
      { locale: I18n.locale }
    end

    def setup_manage_config
      @config = setup_config
      # {
      #   scope: 'manage',
      #   title: 'CMS Admin System',
      #   sessions: {
      #     authentication_key: 'email',
      #     title: 'Welcome To CMS',
      #     description: 'This is a Description',
      #     user_view_disabled: false,
      #   }
      # }
    end

    def setup_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

    def setup_routes
      @routes = []
    end

    def setup_user_view
      if @config[:user_view_disabled] == nil || @config[:user_view_disabled] == false
        user = eval("current_#{@config[:scope]}_user")
        UserView.create!(user: user,
                         view_controller: controller_name,
                         view_action: action_name,
                         view_params: params.to_s,
                         ip_address: request.remote_ip)
      end
    end

  end
end
