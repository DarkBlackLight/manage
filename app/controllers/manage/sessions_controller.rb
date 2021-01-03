# frozen_string_literal: true

class Manage::SessionsController < Devise::SessionsController
  layout 'manage/application'
  # before_action :configure_sign_in_params, only: [:create]
  before_action :setup_config, only: [:new]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def setup_config
    @title = "Welcome To CMS"
    @description = "Smart for CMS"
    @authentication_key = 'email'
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
