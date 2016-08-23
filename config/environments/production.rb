BluefieldsRails::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  config.consider_all_requests_local       = true

  # Code is not reloaded between requests
  config.cache_classes = true
  config.cache_store = :redis_store, ENV['REDIS_STORE_URL'] + '/3/cache'

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Host Domains
  WEB_HOST_DOMAIN = ENV['ROOT_DOMAIN']

  config.action_mailer.default_url_options = { :host => WEB_HOST_DOMAIN }
  config.domain = WEB_HOST_DOMAIN

  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.serve_static_assets = true

  # Compress JavaScripts and CSS
  config.assets.compress = true

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = true

  # Generate digests for assets URLs
  config.assets.digest = true

  # Handle expiration of assets
  # Used with turbo-sprockets-rails3 and the assets:clean_expired task
  config.assets.handle_expiration = true
  
  # Defaults to Rails.root.join("public/assets")
  # config.assets.manifest = YOUR_PATH

  # Specifies the header that your server uses for sending files
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Prepend all log lines with the following tags
  # config.log_tags = [ :subdomain, :uuid ]

  # Use a different logger for distributed setups
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store

  # asset host - AWS Cloud Front CDN
  config.action_controller.asset_host = ENV['ASSET_HOST']

  # mail asset host - AWS Cloud Front CDN
  config.action_mailer.asset_host = ENV['ASSET_HOST']

  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  # JO 26.09.14 - also the utils.js used by my plugin as we lazy load this
  config.assets.precompile += %w( intl-tel-input/lib/libphonenumber/build/utils.js email.css manual-include/* ) # This is for roadie layout

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false
  config.action_mailer.delivery_method = :smtp

  # Enable threaded mode for sidekiq!
  # if `hostname` =~ /sk[0-9]+/
  #   config.threadsafe!
  # end

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :silence

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  # config.active_record.auto_explain_threshold_in_seconds = 0.5
  
  # Roadie Setting
  config.roadie.provider = Roadie::FilesystemProvider.new("", Rails.root.join("public"))

end

ActionMailer::Base.smtp_settings = {
  :address => ENV['MAIL_SERVER'],
  :port => ENV['MAIL_PORT'],
  :domain => ENV['MAIL_DOMAIN'],
  :authentication => ENV['MAIL_PORT'],
  :user_name => ENV['MAIL_USER'],
  :password => ENV['MAIL_PASSWORD']
}