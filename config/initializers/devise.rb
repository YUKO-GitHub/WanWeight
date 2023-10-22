# frozen_string_literal: true

Devise.setup do |config|
  
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'

  require 'devise/orm/active_record'

  
  # config.authentication_keys = [:email]
  # config.request_keys = []
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  # config.params_authenticatable = true
  # config.http_authenticatable = false
  # config.http_authenticatable_on_xhr = true
  # config.http_authentication_realm = 'Application'
  # config.paranoid = true
  config.skip_session_storage = [:http_auth]
  # config.clean_up_csrf_token_on_authentication = true.
  # config.reload_routes = true
  config.stretches = Rails.env.test? ? 1 : 12
  # config.pepper = 'ab1888bdefe10dd06c8d14aed05ba2df3bdfab7f295a6a534550cc6c0455dc1d900c1f7d0d538f5d34bfc7e0572fa416fb0ed2e5099ecb459b5a91d64832d122'
  # config.send_email_changed_notification = false
  # config.send_password_change_notification = false
  # config.allow_unconfirmed_access_for = 2.days
  # config.confirm_within = 3.days
  config.reconfirmable = true
  # config.confirmation_keys = [:email]
  # config.remember_for = 2.weeks
  config.expire_all_remember_me_on_sign_out = true
  # config.extend_remember_period = false
  # config.rememberable_options = {}
  config.password_length = 8..128
  config.email_regexp = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  config.timeout_in = 30.minutes
  # config.lock_strategy = :failed_attempts
  # config.unlock_keys = [:email]
  # config.unlock_strategy = :both
  # config.maximum_attempts = 20
  # config.unlock_in = 1.hour
  # config.last_attempt_warning = true
  # config.reset_password_keys = [:email]
  config.reset_password_within = 6.hours
  config.sign_in_after_reset_password = true
  # config.encryptor = :sha512
  config.scoped_views = true
  # config.default_scope = :user
  config.sign_out_all_scopes = false
  # config.navigational_formats = ['*/*', :html, :turbo_stream]
  config.sign_out_via = :delete
  # config.omniauth :github, 'APP_ID', 'APP_SECRET', scope: 'user,public_repo'
  # config.warden do |manager|
  #   manager.intercept_401 = false
  #   manager.default_strategies(scope: :user).unshift :some_external_strategy
  # end

  # ==> Mountable engine configurations
  # When using Devise inside an engine, let's call it `MyEngine`, and this engine
  # is mountable, there are some extra configurations to be taken into account.
  # The following options are available, assuming the engine is mounted as:
  #
  #     mount MyEngine, at: '/my_engine'
  #
  # The router that invoked `devise_for`, in the example above, would be:
  # config.router_name = :my_engine
  #
  # When using OmniAuth, Devise cannot automatically set OmniAuth path,
  # so you need to do it manually. For the users scope, it would be:
  # config.omniauth_path_prefix = '/my_engine/users/auth'

  config.responder.error_status = :unprocessable_entity
  config.responder.redirect_status = :see_other
  config.sign_in_after_change_password = true
end
