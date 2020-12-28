module ManageUserConcern
  extend ActiveSupport::Concern

  included do

    devise :database_authenticatable, :rememberable, :validatable, :trackable
    belongs_to :source, polymorphic: true

    has_many :user_views

    has_one_attached :avatar

  end
end
