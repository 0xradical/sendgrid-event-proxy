SendgridEventProxy::Application.routes.draw do
  
  match 'sendgrid_event' => 'sendgrid#event', :via => :post

end
