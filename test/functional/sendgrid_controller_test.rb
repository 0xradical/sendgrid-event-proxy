require 'test_helper'

class SendgridControllerTest < ActionController::TestCase
  
  test "any response should be OK" do
    post :event
    assert_response :success
    
    post :event, 'qwerty' => "qwertyu"
    assert_response :success
    
    post :event, 'email' => "thiago@mailinator.com",  'category' => "url#model"
    assert_response :success
  end
  
  test "request parameters" do
    post :event, 'param_one' => "value_one", 'param_two' => "value_two"
    sendgrid_params = assigns(:sendgrid_params)
    assert_equal(sendgrid_params['param_one'],"value_one")
    assert_equal(sendgrid_params['param_two'], "value_two")
  end
  
  test "has created_at timestamp" do
    post :event, 'email' => "thiago@mailinator.com",  'category' => "url#model"
    sendgrid_params = assigns(:sendgrid_params)
    assert_not_nil(sendgrid_params['created_at'])
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
