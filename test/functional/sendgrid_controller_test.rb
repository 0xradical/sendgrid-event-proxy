require 'test_helper'

class SendgridControllerTest < ActionController::TestCase
  
  test "any response to POST event requests should be OK" do
    post :event
    assert_response :success
    
    post :event, 'qwerty' => "qwertyu"
    assert_response :success
    
    post :event, 'email' => "thiago@mailinator.com",  'category' => "url#model"
    assert_response :success
    
    assert_template nil
  end
  
  test "request parameters" do
    post :event, 'event' => "value_one", 'non_existing_attribute' => "value_two"
    sendgrid_params = assigns(:sendgrid_params)
    assert_equal(sendgrid_params['event'],"value_one")
    assert_equal(sendgrid_params['non_existing_attribute'], nil)
  end
    
  test "change type to event_type" do
    post :event, 'type' => "value"
    sendgrid_params = assigns(:sendgrid_params)
    assert_nil(sendgrid_params['type'])
    assert_not_nil(sendgrid_params['event_type'])
    assert_equal(sendgrid_params['event_type'],"value")
  end
  
  test "any post without email field should fail on event creation" do
   post :event, 'category' => "url#model"
   sendgrid_event = assigns(:sendgrid_event)
   assert_nil(sendgrid_event)
   
   
   post :event, 'email' => "thiago@mailinator.com", 'category' => "url#model"
   sendgrid_event = assigns(:sendgrid_event)
   assert_not_nil(sendgrid_event)
  end
    
end
