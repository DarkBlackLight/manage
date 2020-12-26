module ManageUserConcern
  extend ActiveSupport::Concern

  included do

    devise :database_authenticatable, :rememberable, :validatable, :trackable
    belongs_to :source, polymorphic: true


  end
end
