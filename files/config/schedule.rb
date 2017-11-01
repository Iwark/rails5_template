require File.expand_path(File.dirname(__FILE__) + "/environment")
rails_env = ENV['RAILS_ENV'] || :development
env :PATH, ENV['PATH']
set :output, "log/crontab.log"
set :environment, rails_env

every 1.day, :at => '1:00 am' do
  # rake "hoge:fuga"
end
