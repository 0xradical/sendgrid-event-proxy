class AddTimestampToSendgridEvents < ActiveRecord::Migration
  def self.up
    add_column :sendgrid_events, :timestamp, :string
  end

  def self.down
    remove_column :sendgrid_events, :timestamp
  end
end
