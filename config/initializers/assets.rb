# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# If you are using Sprockets 4, Rails changes it's default logic for determining top-level targets. It will now use only a file at ./app/assets/config/manifest.js
# See: https://github.com/rails/sprockets/blob/master/UPGRADING.md

Rails.application.config.assets.precompile += %w( accession_number_updates.js )
Rails.application.config.assets.precompile += %w( accession_numbers.js )

# sul_styles 0.2.0 adds a Regexp to precompile which sprockets 4.x doesn't support.
# Must run after_initialize so it fires after the engine initializer adds the Regexp.
Rails.application.config.after_initialize do
  Rails.application.config.assets.precompile.reject! { |e| e.is_a?(Regexp) }
  Rails.application.config.assets.precompile += %w( sul-icons.eot sul-icons.svg sul-icons.ttf sul-icons.woff )
end