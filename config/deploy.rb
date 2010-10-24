# be sure to change these
set :user, 'korujito'
set :domain, 'champz.com.br'
set :application, "champz"
set :domain_server, 'grizzlies.dreamhost.com'

# file paths
set :repository, "git@github.com:kinfante/#{application}.git"
set :deploy_to, "/home/#{user}/#{domain}"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

role :app, domain_server
role :web, domain_server
role :db,  domain_server, :primary => true

default_run_options[:pty] = true

# miscellaneous options
set :deploy_via, :remote_cache
set :scm, 'git'
set :branch, 'master'
set :scm_verbose, true
set :use_sudo, false

# task which causes Passenger to initiate a restart
namespace :deploy do
    task :restart do
        run "touch #{current_path}/tmp/restart.txt"
    end
end

# optional task to reconfigure databases
after "deploy:update_code", :configure_database
desc "copy database.yml into the current release path"
task :configure_database, :roles => :app do
    db_config = "#{deploy_to}/config/database.yml"
    run "cp #{db_config} #{release_path}/config/database.yml"
end
