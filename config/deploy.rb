require "bundler/capistrano"
require "rvm/capistrano"

set :application, "ebritton.com"
set :repository,  "git://github.com/kmcphillips/ebritton.com.git"
set :deploy_to, "/home/kevin/ebritton.com"
set :user, "kevin"
set :use_sudo, false
set :scm, "git"
set :keep_releases, 5

default_run_options[:pty] = true

role :web, "198.211.110.159"
role :app, "198.211.110.159"
role :db,  "198.211.110.159", :primary => true


namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after "deploy:update", "deploy:cleanup"

after "deploy:finalize_update", "symlink_shared_files"

task :symlink_shared_files do
  run "ln -s #{shared_path}/uploads #{release_path}/public/uploads"
  run "ln -s #{shared_path}/legacy_images #{release_path}/public/images"

  %w{database.yml}.each do |config|
    run "ln -s #{shared_path}/#{config} #{release_path}/config/#{config}"
  end
end

