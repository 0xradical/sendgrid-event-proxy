SendgridEventProxy::Application.configure do
  config.cache_classes = true
  config.whiny_nils = true
  config.consider_all_requests_local       = true
  config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = true
  config.active_support.deprecation = :log
end

