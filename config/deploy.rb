require "rvm/capistrano"  # Load RVM's capistrano plugin. https://rvm.io/integration/capistrano/
require "bundler/capistrano" # Bundler will be activated after each new deployment. http://gembundler.com/deploying.html

default_run_options[:pty] = true # Must be set for the password prompt

set :use_sudo, false

set :application, "ideasbulb" # Set Application Name
set :repository,  "git@bitbucket.org:danjiang/ideasbulb.git" # Set Source Code Repository
set :scm, :git # Set SCM

set :deploy_to, "/var/www/ideasbulb" # Deployed Server Directory

role :app, "www.ideasbulb.com" # Set Application Server Address
role :web, "www.ideasbulb.com" # Set Web Server Address
role :db,  "www.ideasbulb.com", :primary => true # Set Database Server Address

set :rvm_type, :system  # Copy the exact line. I really mean :system here
set :rvm_ruby_string, 'ruby-1.9.2-p290@ideasbulb' # Set RVM Env You Want App To Run In

namespace :foreman do
  desc "Start the application services"
  task :start, :roles => :app do
    run "#{sudo} start #{application}"
  end

  desc "Stop the application services"
  task :stop, :roles => :app do
    run "#{sudo} stop #{application}"
  end

  desc "Restart the application services"
  task :restart, :roles => :app do
    run "#{sudo} start #{application} || #{sudo} restart #{application}"
  end

  desc "Display logs for a certain process - arg example: PROCESS=web-1"
  task :logs, :roles => :app do
    run "cd #{current_path}/log && cat #{ENV["PROCESS"]}.log"
  end

  desc "Export the Procfile to upstart scripts"
  task :export, :roles => :app do
    run "#{sudo} whoami" # remember sudo password,later run rvmsudo without password
    run "cd #{current_path} && rvmsudo bundle exec foreman export upstart /etc/init -a #{application} -l #{shared_path}/log -u root -f #{current_path}/Procfile.production -c worker=2"
  end 
end

namespace :deploy do

  desc "Symlink extra configs and folders."
  task :symlink_extras, :roles => :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/app_config.yml #{release_path}/config/app_config.yml"
  end

  desc "Setup shared directory.Upload config examples`s files"
  task :setup_shared, :roles => :app  do
    run "mkdir -p #{shared_path}/config"
    # Read Local File and Upload
    put File.read("config/examples/database.yml"), "#{shared_path}/config/database.yml"
    put File.read("config/examples/app_config.yml"), "#{shared_path}/config/app_config.yml"
  end

  desc "Restarts your application."
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

end

namespace :sunspot do
  desc "Reindex solr search index"
  task :reindex, :roles => :app do
    run "cd #{current_path} && #{rake} RAILS_ENV=#{rails_env} sunspot:reindex"
  end
end

# Following tasks will be triggered after cap deploy:setup
# $ cap deploy:setup -S skip_setup_shared=true
after "deploy:setup", "deploy:setup_shared" unless fetch(:skip_setup_shared, false)
# Following tasks will be triggered after cap deploy:update_code
after "deploy:update_code", "deploy:symlink_extras"
after "deploy:update_code", "deploy:migrate"
#after "deploy:update_code", "foreman:restart"
