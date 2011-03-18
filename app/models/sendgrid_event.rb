class SendgridEvent < ActiveRecord::Base
  
  after_create :queue
  
  def queue
    Delayed::Job.enqueue(self)
  end
  
  def perform
    
  end
  
end