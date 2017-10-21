require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require "whenever/capistrano"
require 'capistrano/rails/console'
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }

require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git
