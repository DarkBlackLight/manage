module Manage
  module UserConcern
    extend ActiveSupport::Concern

    included do
      devise :database_authenticatable, :rememberable, :validatable, :trackable

      belongs_to :source, polymorphic: true

      before_save :set_full_name
      after_save :set_source_full_name

      def set_full_name
        self.full_name = "#{first_name} #{last_name}"
      end

      def set_source_full_name
        if self.source.full_name != self.full_name
          self.source.update_attribute(:full_name, self.full_name)
        end
      end
    end
  end
end
