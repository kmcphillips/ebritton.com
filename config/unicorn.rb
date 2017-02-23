# set path to application
project_dir = "/var/apps/ebritton.com"
current_dir = "#{ project_dir }/current"
shared_dir = "#{ project_dir }/shared"

before_exec do |server|
  ENV["BUNDLE_GEMFILE"] = "#{ current_dir }/Gemfile"
end

working_directory current_dir

# Set unicorn options
worker_processes 2
preload_app true
timeout 30

# Set up socket location
listen "#{ shared_dir }/tmp/sockets/unicorn.sock", backlog: 64

# Logging
stderr_path "#{ shared_dir }/log/unicorn.stderr.log"
stdout_path "#{ shared_dir }/log/unicorn.stdout.log"

# Set master PID location
pid "#{ shared_dir }/tmp/pids/unicorn.pid"
