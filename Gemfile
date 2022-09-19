source 'https://rubygems.org'
ruby '2.7.1'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.8.1'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.5.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', group: :doc
# A gem for adding Stanford University Libraries styles to Rails applications
gem 'sul_styles'
# Use sass-powered bootstrap
gem 'bootstrap-sass'
# Use bootstrap_form for easy form building
gem 'bootstrap_form'
# Use SCSS for stylesheets
gem 'sassc-rails'
# Use jquery as the JavaScript library
# (pinning to < 4.1 until issue w/ webshims is resolved https://github.com/aFarkas/webshim/issues/560)
gem 'jquery-rails'
# Use cancancan for authorization
gem 'cancancan'
# composite_primary_keys for models that have two or more primary_keys
gem 'composite_primary_keys'
# Use Unicorn as the app server
# gem 'unicorn'
# Use Faraday for making http requests
gem 'faraday'
# A gem for simple rails environment specific config
gem 'config'
# Use okcomputer to set up checks to monitor
gem 'okcomputer'
# Use nokogiri for xml printing
gem 'nokogiri', '>= 1.10.5'
# Use systemu to handle OS calls
gem 'systemu'
# For exception reporting
gem 'honeybadger'
# For uploading files from Ruby applications
gem 'carrierwave'
# to compress javascript
gem 'uglifier'
# For fiscal year functions
gem 'fiscali'
# To filter Sal3BatchRequestsBatches to day of the week
gem 'has_scope'
# To parse tsv for DigitalBookplate data
gem 'tsv'
# Rails javascript runtime environment
gem 'therubyracer'
# To query an sqlserver instance (lobbytrack)
gem 'tiny_tds', '~> 2.1.3'
# Pin mimemagic to fix issue with rails 5.2
gem 'mimemagic', '0.4.3'

group :production do
  gem 'activerecord-oracle_enhanced-adapter', '~> 5.2.8'
  gem 'ruby-oci8'
  gem 'ruby-plsql'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debug console
  gem 'byebug'
  gem 'rails-controller-testing'
  gem 'rspec-rails'

  # Rubocop is a static code analyzer to enforce style.
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'

  # scss-lint will test the scss files to enforce styles
  gem 'scss_lint', require: false

  # Capybara for feature/integration tests
  gem 'capybara'

  # Coveralls for code coverage
  gem 'coveralls', require: false

  gem 'factory_bot_rails'

  gem 'webdrivers'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console'
end

group :deployment do
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-passenger'
  gem 'capistrano-rails'
  gem 'dlss-capistrano'
end
