source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2.7.1'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# A gem for adding Stanford University Libraries styles to Rails applications
gem 'sul_styles'

# Use sass-powered bootstrap
gem 'bootstrap-sass', "~> 3.3.4"
# Use bootstrap_form for easy form building
gem 'bootstrap_form'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Use cancan for authorization
gem 'cancan'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# composite_primary_keys for models that have two or more primary_keys
gem 'composite_primary_keys', '=8.1.4'
# Use Unicorn as the app server
# gem 'unicorn'
# Use Faraday for making http requests
gem 'faraday'
# A gem for simple rails environment specific config
gem 'config'
# Use okcomputer to set up checks to monitor
gem 'okcomputer'
# Use sidekiq for background jobs
gem 'sidekiq'

group :production do
  gem 'activerecord-oracle_enhanced-adapter', '~> 1.6.0'
  gem 'ruby-oci8'
end

gem 'therubyracer'

group :deployment do
  gem 'capistrano', '~> 3.0'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-passenger'
  gem 'capistrano-sidekiq'
  gem 'dlss-capistrano'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debug console
  gem 'byebug'
  gem 'rspec-rails', '~> 3.0'

  # Rubocop is a static code analyzer to enforce style.
  gem 'rubocop', require: false

  # scss-lint will test the scss files to enforce styles
  gem 'scss_lint', require: false

  # Capybara for feature/integration tests
  gem 'capybara'

  #Coveralls for code coverage
  gem 'coveralls', require: false

  gem 'factory_girl_rails'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end
