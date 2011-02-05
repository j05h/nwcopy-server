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

  GITHUBACCESS = 'f6a874390ff78672a9e9' #'701aa6c7863e2f650be2'
  GITHUBSECRET = 'd27d40b122b9b5bf49720171ccf1ad9d8d5742d9' #'2fc16398de8fe58899089759394ecdb899874a3f'
end
