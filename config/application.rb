require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module SCPX
  class Application < Rails::Application
    TIMEZONE  = ENV['default_timezone'] || 'UTC'
    LOCALE    = ENV['default_locale']   || 'en'

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = TIMEZONE

    config.i18n.default_locale = LOCALE

    # DB schema in SQL instead of Ruby
    config.active_record.schema_format = :sql

    # Custom lib directories
    config.autoload_paths += %W(#{config.root}/lib)

    # Devise layout
    config.to_prepare do
      Devise::SessionsController.layout "minimal"
      Devise::RegistrationsController.layout proc{ |controller| user_signed_in? ? "application" : "minimal" }
      Devise::ConfirmationsController.layout "minimal"
      Devise::UnlocksController.layout "minimal"            
      Devise::PasswordsController.layout "minimal" 
    end
  end
end
