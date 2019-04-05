require 'dotenv/load'

set :stage, :production
set :rails_env, :production
set :branch,  :master

server "#{ENV['SERVER_IP']}",
  user: "#{ENV['SERVER_USER']}",
  roles: %w{web app db},
  ssh_options: {
    user: "#{ENV['SERVER_USER']}", # overrides user setting above
    keys: [ENV['PEM_FILE_PATH']],
    forward_agent: false,
    # auth_methods: %w(publickey password)
    # password: "please use keys"
  }
