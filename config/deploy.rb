lock '3.6.1'

set :application, 'ebritton.com'
set :repo_url, 'https://github.com/kmcphillips/ebritton.com.git'

set :user, "deploy"
set :rbenv_ruby, "2.3.1"

# Default value for :linked_files is []
# append :linked_files, 'config/database.yml', 'config/secrets.yml'

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/.well-known'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 2

# Unicorn
# set :unicorn_pid, -> { File.join(current_path, "tmp", "pids", "unicorn.pid") }
set :unicorn_config_path, -> { File.join(current_path, "config", "unicorn.rb") }
# set :unicorn_roles, -> { :app }
# set :unicorn_options, -> { "" }
# set :unicorn_rack_env, -> { fetch(:rails_env) == "development" ? "development" : "deployment" }
# set :unicorn_restart_sleep_time, 3
