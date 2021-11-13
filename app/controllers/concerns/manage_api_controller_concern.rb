module ManageApiControllerConcern
  extend ActiveSupport::Concern
  included do
    skip_before_action :verify_authenticity_token
    before_action :setup_user

    def setup_user
      if request.headers['Authorization'] && (request.headers['Authorization'].include? 'Bearer')
        @current_user = User.find_by_token(request.headers['Authorization'].split(' ')[1])
        @current_user = nil unless @current_user && @current_user.token
      end
    end

    def setup_view(current_user)
      UserView.create(user: current_user,
                      view_controller: controller_name,
                      view_action: action_name,
                      view_params: params.to_s,
                      ip_address: request.remote_ip)
    end

    def unauthorized_message
      'unauthorized'
    end

    rescue_from CanCan::AccessDenied do
      render json: { data: unauthorized_message }, status: :unauthorized
    end

  end
end
