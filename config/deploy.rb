# RVM bootstrap
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'rvm/capistrano'
set :rvm_ruby_string, 'ruby-1.9.2-p290@venuedog'

#We have RVM setup on webadmin, not system wide. Therefore, this:
set :rvm_type, :user

# bundler bootstrap
require 'bundler/capistrano'

set :application, "venuedog"
set :repository,  "gitosis@saidev.co:venuedog.git"

set :deploy_to, "/home/webadmin/#{application}"
set :use_sudo, false

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "saidev.co"                          # Your HTTP server, Apache/etc
role :app, "saidev.co"                          # This may be the same as your `Web` server
role :db,  "saidev.co", :primary => true # This is where Rails migrations will run

set :rails_env, "staging"

set :user, "webadmin"
set :branch, "master"
set :deploy_via, :remote_cache

default_run_options[:pty] = true
set :ssh_options, { :forward_agent => true }

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# tasks

namespace :delayed_job do
    desc "Restart the delayed_job process"
    task :restart, :roles => :app do
        run "cd #{current_path}; RAILS_ENV=#{rails_env} script/delayed_job restart"
    end
end

namespace :deploy do
  task :restart, :roles => :app, :except => {:no_release => true} do
    run "start-stop-daemon --stop --name nginx ; true"
    run "cd #{deploy_to}/current && passenger start -a 127.0.0.1 -p 3000 -d -e #{rails_env}"
  end
end

#namespace :deploy do
#  task :start, :roles => :app do
#    run "touch #{current_path}/tmp/restart.txt"
#  end
#
#  task :stop, :roles => :app do
    # Do nothing.
#  end

#  desc "Restart Application"
#  task :restart, :roles => :app do
#    run "touch #{current_path}/tmp/restart.txt"
#  end
#end

#Make sure the rvmrc file gets trusted
#
namespace :rvm do
  task :trust_rvmrc do
      run "rvm rvmrc trust #{release_path}"
  end
end

after "deploy", "rvm:trust_rvmrc"
after "deploy", "delayed_job:restart"
after "deploy:migrations", "delayed_job:restart"
after "deploy:migrate", "delayed_job:restart"
after "deploy:migrations", "rvm:trust_rvmrc"
after "deploy:migrate", "rvm:trust_rvmrc"
