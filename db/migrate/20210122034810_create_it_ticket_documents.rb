class CreateItTicketDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :it_ticket_documents do |t|
      t.integer :it_ticket_id
      t.integer :index
      
      t.timestamps
    end
  end
end
