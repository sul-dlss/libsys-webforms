require_relative 'boot'

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LibsysWebforms
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Pacific Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.fallbacks = [I18n.default_locale]

    # Do not swallow errors in after_commit/after_rollback callbacks.
    # config.active_record.raise_in_transactional_callbacks = true
    config.eager_load_paths << Rails.root.join('lib')
    config.sass.load_paths << File.expand_path('../../vendor/assets/stylesheets/')
    config.active_record.default_timezone = :local

    # DEPRECATION WARNING: Leaving `ActiveRecord::ConnectionAdapters::SQLite3Adapter.represent_boolean_as_integer`
    # set to false is deprecated. SQLite databases have used 't' and 'f' to serialize
    # boolean values and must have old data converted to 1 and 0 (its native boolean
    # serialization) before setting this flag to true.
    # Note: Libsys-webforms does not have any boolean columns in the schema.
    # config.active_record.sqlite3.represent_boolean_as_integer = true

    config.email_pattern = /(\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,}\s*)([;,\s]+([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,}))*\z)/i
  end
end
