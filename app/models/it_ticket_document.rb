class ItTicketDocument < ApplicationRecord
  belongs_to :it_ticket
  has_one_attached :document

  def document_data
    document.attached? ? { src: url_for(document), filename: document.filename, content_type: document.content_type } : nil
  end

end
