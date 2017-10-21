source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.2'
gem 'sqlite3'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.5'
gem 'therubyracer', platforms: :ruby
gem 'slim-rails'
gem 'bootstrap-sass'
gem 'simple_form'
gem 'action_args'
gem 'active_decorator'
gem 'html5_validators'
gem 'rails-flog'
gem 'whenever', require: false
gem 'newrelic_rpm'
gem 'kaminari'
gem 'nokogiri'
gem 'unicorn'
gem 'seed-fu', '~> 2.3'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'annotate'
  gem 'pry-rails'
  gem 'pry-coolline'
  gem 'pry-byebug'
  gem 'rb-readline'
  gem 'hirb'
  gem 'hirb-unicode'
  gem 'awesome_print'
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
  gem 'guard-rspec'
  gem 'rb-fsevent'
  gem 'factory_bot_rails'
  gem 'database_rewinder'
  gem 'timecop'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'html2slim'
  gem 'bullet'
  # gem 'rack-mini-profiler'
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano-bundler'
  gem 'capistrano-rails-console'
end

group :test do
  gem 'shoulda-matchers'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
