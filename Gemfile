source 'https://rubygems.org'
ruby '3.3.5'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'
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
# A gem for simple rails environment specific config
gem 'config'
# Use okcomputer to set up checks to monitor
gem 'okcomputer'
# For exception reporting
gem 'honeybadger'
# HTTP 1.1 server for Ruby/Rack applications.
gem 'puma'
# Provides a clear syntax for writing and deploying cron jobs.
gem 'whenever'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debug console
  gem 'byebug'
  gem 'rails-controller-testing'
  gem 'rspec-rails'

  # Rubocop is a static code analyzer to enforce style.
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-factory_bot'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'rubocop-rspec_rails'
  gem 'rubocop-capybara'

  # scss-lint will test the scss files to enforce styles
  gem 'scss_lint', require: false

  # Capybara for feature/integration tests
  gem 'capybara'

  # Coveralls for code coverage
  gem 'coveralls', require: false

  gem 'factory_bot_rails'

  gem 'selenium-webdriver'
  # gem 'webdrivers'
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
  # gem 'capistrano-rvm'
end
