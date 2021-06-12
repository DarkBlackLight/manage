class Manage::InvitationsController < Devise::InvitationsController
  layout 'manage/application'
  before_action :setup_manage_config

  def setup_manage_config
    @config = setup_config
  end
end