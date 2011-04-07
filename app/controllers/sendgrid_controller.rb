class SendgridController < ApplicationController
  
  skip_before_filter :verify_authenticity_token
  
  def event
    begin
      sendgrid_params = request.request_parameters
      sendgrid_params.merge!({"created_at" => Time.now})
      sendgrid_params.merge!({"event_type" => sendgrid_params.delete("type")}) if sendgrid_params["type"]
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