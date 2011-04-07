require 'test_helper'

class SendgridEventTest < ActiveSupport::TestCase
  fixtures :sendgrid_events
  
  def setup
    @sendgrid_event = sendgrid_events(:one)
  end
  
  test "email normalization" do
    sendgrid_event = SendgridEvent.new(:email => "<thiago@mailinator.com>")
    old_email = sendgrid_event.email
    sendgrid_event.normalize_email
    new_email = sendgrid_event.email
    
    assert_match(/[\<\>]/, old_email)
    assert_no_match(/[\<\>]/, new_email)
  end
  
  
  test "ampersandization" do
    sendgrid_event = SendgridEvent.new(:event => "event",
                                       :email => "email@email.com",
                                       :category => "url#model",
                                       :reason => "reason",
                                       :response => "attempt",
                                       :event_type => "type",
                                       :status => "status",
                                       :url => "www.google.com")
    assert_equal(sendgrid_event.to_ampersand_separated_s,
                 "event=event&email=email@email.com&category=url%23model&reason=reason&response=attempt&event_type=type&status=status&url=www.google.com")
  end
  
  test "url_to_post" do
    sendgrid_event = SendgridEvent.new(:category => "url#model")
    assert_equal(sendgrid_event.url_to_post, "url/sendgrid_event")
  end
  
end