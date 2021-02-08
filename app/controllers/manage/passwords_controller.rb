# frozen_string_literal: true

class Manage::PasswordsController < Devise::PasswordsController
  layout 'manage/application'
  before_action :setup_manage_config

  def setup_manage_config
    @config = setup_config
  end
end
