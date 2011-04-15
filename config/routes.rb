SendgridEventProxy::Application.routes.draw do
  
  match 'sendgrid_event' => 'sendgrid#event', :via => :post

  match '/' => proc { |env| [200, {}, ""] }
    
  match ':controller(/:action(/:id))' => proc { |env| [200, {}, ""] }, :constraints => {:id => /.*/}  

end
