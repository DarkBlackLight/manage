class UserView < ApplicationRecord
  scope :query_date_from, ->(q) { where('user_views.created_at >= ?', Time.zone.parse(q)) }
  scope :query_date_to, ->(q) { where('user_views.created_at <= ?', Time.zone.parse(q)) }

  belongs_to :user, optional: true
end
