require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WanWeight
  class Application < Rails::Application
    config.load_defaults 7.0
    config.i18n.default_locale = :ja
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    config.beginning_of_week = :sunday


    config.generators do |g|
      g.assets false
      g.test_framework false
      g.test_framework :rspec,
        fixtures: false,
        controller_specs: false,
        view_specs: false,
        helper_specs: false,
        routing_specs: false
    end

    config.generators.system_tests = nil
    config.active_storage.variant_processor = :mini_magick
  end
end
