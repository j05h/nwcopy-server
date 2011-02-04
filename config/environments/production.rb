NwcopyServer::Application.configure do
  config.cache_classes = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.action_dispatch.x_sendfile_header = "X-Sendfile"
  config.serve_static_assets = false
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify

  config.logger    = Logger.new STDOUT
  config.log_level = :info

  GITHUBACCESS = '701aa6c7863e2f650be2'
  GITHUBSECRET = '2fc16398de8fe58899089759394ecdb899874a3f'
end
