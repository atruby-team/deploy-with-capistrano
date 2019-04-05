require 'dotenv/load'

set :application, "#{ENV['APP_NAME']}"
set :user_sudo, true
set :sudo, "sudo -u #{ENV['SERVER_USER']} -i"
set :repo_url, "#{ENV['LINK_REPO']}"
set :pty, true
set :linked_files, %w(config/database.yml config/application.yml config/master.key)
set :linked_dirs, %w(log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads)
set :keep_releases, 5
set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, "#{ENV['RUBY_VERSION']}"
set :deploy_to, "#{ENV['DEPLOY_TO']}"

set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
# set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

after 'deploy:publishing', 'deploy:restart'

namespace :deploy do
  task :restart do
    invoke 'unicorn:stop'
    invoke 'unicorn:start'
  end
end
