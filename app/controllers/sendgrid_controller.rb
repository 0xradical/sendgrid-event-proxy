class SendgridController < ApplicationController
  
  skip_before_filter :verify_authenticity_token
  
  def event
    begin
      sendgrid_params = request.request_parameters.merge({:created_at => Time.now})
      SendgridEvent.create(sendgrid_params)
    rescue
      nil
    end
    render :nothing => true
  end
  
  # Curl:
  # curl -D - -d "event=processed&email=test" http://localhost:3000/sendgrid_event
  #
  # Curb:   
  # Curl::Easy::http_post("http://localhost:3000/sendgrid_event","event=processed&email=test")
  
  
end