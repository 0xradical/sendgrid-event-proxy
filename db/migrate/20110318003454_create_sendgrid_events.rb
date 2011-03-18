class CreateSendgridEvents < ActiveRecord::Migration
  def self.up
    create_table :sendgrid_events do |table|
      table.string :event    
      table.string :email    
      table.string :category 
      table.string :reason  
      table.string :response
      table.string :attempt  
      table.string :type   
      table.string :status
      table.string :url
      table.timestamps      
    end
  end

  def self.down
    drop_table :sendgrid_events
  end
end
