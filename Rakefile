# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('config/application', __dir__)

Rails.application.load_tasks

task default: %i[rubocop scss_lint spec display_coveralls_coverage]
task no_cop: %i[scss_lint spec display_coveralls_coverage]
