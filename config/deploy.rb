set :application, 'libsys-webforms'
set :repo_url, 'git@github.com:sul-dlss/libsys-webforms.git'

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/opt/app/libsys/libsys-webforms'

# Default value for :log_level is :debug
set :log_level, :info

# Default restart method: `passenger-config restart-app`
set :passenger_restart_with_touch, false # Note that `nil` is NOT the same as `false` here

# Default value for :linked_files is []
set :linked_files, %w(config/secrets.yml config/honeybadger.yml db/production.sqlite3 log/cron.log)
# Default value for linked_dirs is []
set :linked_dirs, %w(log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads config/settings)

# Default value for keep_releases is 5
# set :keep_releases, 5

before 'deploy:restart', 'shared_configs:update'
after 'deploy:updated', 'database:write_crontab'

namespace :database do
    desc 'Seed the database'
    task :seed do
        on roles(:app) do
            within release_path do
                execute :bundle, :exec, "rails db:seed"
            end
        end
    end

    desc 'Update the crontab that copies the database file'
    task :write_crontab do
        on roles(:app) do
            within release_path do
                execute :bundle, :exec, "whenever --write-crontab"
            end
        end
    end 
end
