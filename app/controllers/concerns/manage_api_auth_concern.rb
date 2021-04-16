module ManageApiAuthConcern
  extend ActiveSupport::Concern
  included do

    def current
      if @current_user
        render json: set_show_json(@current_user)
      else
        render json: { data: 'Unauthorized' }, status: :unprocessable_entity
      end
    end

    def validate_username_password
      @resource = User.find_by_username(params[:user][:username])

      if @resource && @resource.password == params[:user][:password]
        @resource.update_columns({ token: Digest::SHA1.hexdigest(Time.zone.now.to_s + @resource.full_name), token_created_at: Time.now })
        render json: set_show_json(@resource), status: :ok
      else
        render json: { data: 'Password is not valid' }, status: :unprocessable_entity
      end
    end

    def validate_email_password
      @resource = User.find_by_email(params[:user][:email])

      if @resource && @resource.password == params[:user][:password]
        @resource.update_columns({ token: Digest::SHA1.hexdigest(Time.zone.now.to_s + @resource.full_name), token_created_at: Time.now })
        render json: set_show_json(@resource), status: :ok
      else
        render json: { data: 'Password is not valid' }, status: :unprocessable_entity
      end
    end

    private

    def resource_params
      params.require(:user).permit(:email, :username, :password)
    end

    def set_index_json(resources)
      resources.as_json(only: [:id, :first_name, :last_name, :full_name, :email, :username, :token])
    end

    def set_show_json(resource)
      resource.as_json(only: [:id, :first_name, :last_name, :full_name, :email, :username, :token])
    end

  end
end

