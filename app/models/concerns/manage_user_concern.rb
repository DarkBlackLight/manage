module ManageUserConcern
  extend ActiveSupport::Concern

  included do

    devise :database_authenticatable, :recoverable, :registerable, :rememberable, :validatable, :trackable
    belongs_to :source, polymorphic: true
    accepts_nested_attributes_for :source

    has_many :user_views

    has_one_attached :avatar

  end
end
