class SendgridController < ApplicationController
  
  skip_before_filter :verify_authenticity_token
  
  def event
    SendgridEvent.create(request.request_parameters) rescue nil
    render :nothing => true
  end
  
  # para testar:
  # curl -D - -d "event=processed&email=test" http://localhost:3000/sendgrid_event.json
  
end