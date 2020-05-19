set :application, 'libsys-webforms'
set :repo_url, 'https://github.com/sul-dlss/libsys-webforms.git'

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/opt/app/libsys/libsys-webforms'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :info

# Default value for :pty is false
# set :pty, true

# Default restart method: `passenger-config restart-app`
set :passenger_restart_with_touch, false # Note that `nil` is NOT the same as `false` here

# Default value for :linked_files is []
set :linked_files, %w(config/secrets.yml config/database.yml config/honeybadger.yml)
# Default value for linked_dirs is []
set :linked_dirs, %w(log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads config/settings loc_marc2bibframe2)
# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :loc do

  desc 'git clone LOC marc2bibframe2 (if it does not exist already)'
  task :clone_marc2bibframe2 do
    on roles(:web) do
      cmd  = "cd #{shared_path} && "
      cmd += "if [ ! ls -A loc_marc2bibframe2 ]; then "
      cmd += "  git clone https://github.com/lcnetdev/marc2bibframe2.git loc_marc2bibframe2; "
      cmd += "fi"
      execute cmd
    end
  end

  desc 'git pull master for LOC marc2bibframe2'
  task update_marc2bibframe2: :clone_marc2bibframe2 do
    on roles(:web) do
      execute "cd #{shared_path}/loc_marc2bibframe2 && git pull origin master"
    end
  end

end

before 'deploy:updated', 'loc:update_marc2bibframe2'
before 'deploy:restart', 'shared_configs:update'

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      within release_path do
        execute "cd #{release_path.join('lib')} && \
          curl -sOL https://github.com/sul-dlss/ld4p-marc21-to-xml/releases/download/v1.1.0/xform-marc21-to-xml-jar-with-dependencies.jar"
      end
    end
  end

end
