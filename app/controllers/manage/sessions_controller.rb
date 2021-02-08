class Manage::SessionsController < Devise::SessionsController
  layout 'manage/application'
  before_action :setup_manage_config

  def setup_manage_config
    @config = setup_config
  end
end
