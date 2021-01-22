class ItTicket < ApplicationRecord
  has_many :it_ticket_documents, :dependent => :destroy
  belongs_to :user

  enum it_ticket_type: [:bug, :feature]
  enum it_ticket_status: [:waiting, :in_process, :rejected, :implemented]
  enum it_ticket_level: [:low, :medium, :high, :super_high]
end
