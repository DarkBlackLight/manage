module ManageApiControllerConcern
  extend ActiveSupport::Concern
  included do
    before_action :setup_user

    def setup_user
      if request.headers['Authorization'] && (request.headers['Authorization'].include? 'Bearer')
        @current_user = User.find_by_token(request.headers['Authorization'].split(' ')[1])
        @current_user = nil unless @current_user && @current_user.token
      end
    end

    rescue_from CanCan::AccessDenied do
      render json: { data: 'unauthorized' }, status: :unauthorized
    end

  end
end
