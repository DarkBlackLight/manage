# frozen_string_literal: true

class Manage::RegistrationsController < Devise::RegistrationsController
  layout 'manage/application'
  before_action :setup_manage_config

  def setup_manage_config
    @config = setup_config
  end
end
