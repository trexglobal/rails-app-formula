# Minimal sample configuration file for Unicorn (not Rack) when used
# with daemonization (unicorn -D) started in your working directory.
#
# See http://unicorn.bogomips.org/Unicorn/Configurator.html for complete
# documentation.
# See also http://unicorn.bogomips.org/examples/unicorn.conf.rb for
# a more verbose configuration using more features.

listen 3000 # by default Unicorn listens on port 8080

env = ENV["RAILS_ENV"] || "development"

# Preload our app for more speed
#preload_app true

# listen on both a Unix domain socket and a TCP port,
# we use a shorter backlog for quicker failover when busy
# listen "/tmp/simplifyem.socket", :backlog => 64

# nuke workers after 30 seconds instead of 60 seconds (the default)
timeout 300

worker_processes 8 # this should be >= nr_cpus
APP_BASE="/srv"

# Production specific settings
if env == "production"

  preload_app true

  # Help ensure your application will always spawn in the symlinked
  # "current" directory that Capistrano sets up.
  working_directory "#{APP_BASE}/current"

  # feel free to point this anywhere accessible on the filesystem
  user 'app', 'app'
  shared_path = "#{APP_BASE}/shared"

  pid "#{APP_BASE}/shared/tmp/unicorn.pid"
  stderr_path "#{APP_BASE}/shared/log/unicorn.log"
  stdout_path "#{APP_BASE}/shared/log/unicorn.error.log"
end

# before_fork do |server, worker|

#   Signal.trap 'TERM' do
#     puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
#     Process.kill 'QUIT', Process.pid
#   end

#   defined?(ActiveRecord::Base) and
#     ActiveRecord::Base.connection.disconnect!
# end

# after_fork do |server, worker|

#   Signal.trap 'TERM' do
#     puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to sent QUIT'
#   end

#   defined?(ActiveRecord::Base) and
#     ActiveRecord::Base.establish_connection(
#       Rails.application.config.database_configuration[Rails.env]
#     )

# end
