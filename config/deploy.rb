require "bundler/capistrano"

set :application, "ebritton.com"
set :repository,  "git://github.com/kimos/ebritton.com.git"
set :deploy_to, "/var/www/kevin/data/www/ebritton.com"
set :user, "kevin"
set :use_sudo, false
set :scm, "git"
set :keep_releases, 5

default_run_options[:pty] = true

role :web, "68.169.58.121"
role :app, "68.169.58.121"
role :db,  "68.169.58.121", :primary => true


namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after "deploy:update", "deploy:cleanup"

after "deploy", "symlink_shared_files"

task :symlink_shared_files do
  run "ln -s #{shared_path}/uploads #{release_path}/public/uploads"
  run "ln -s #{shared_path}/legacy_images #{release_path}/public/images"

  %w{database.yml}.each do |config|
    run "ln -s #{shared_path}/#{config} #{release_path}/config/#{config}"
  end
end
