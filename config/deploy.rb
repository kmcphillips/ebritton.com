lock '3.6.1'

set :application, 'ebritton.com'
set :repo_url, 'https://github.com/kmcphillips/ebritton.com.git'

append :linked_dirs, 'public/.well-known'

set :user, "deploy"
set :rbenv_ruby, "2.3.1"

set :keep_releases, 2
