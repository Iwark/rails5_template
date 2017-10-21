def get_remote(src, dest = nil)
  dest ||= src
  repo = 'https://raw.github.com/Iwark/rails5_template/master/files/'
  remote_file = repo + src
  remove_file dest
  get(remote_file, dest)
end

# アプリ名の取得
@app_name = app_name

@repo = ask("Type github repository name ex: Iwark/rails5_template")

# gitignore
get_remote('gitignore', '.gitignore')

# Gemfile
get_remote('Gemfile')

# Database
if yes?('use PostgreSQL?(y/n)')
  gsub_file 'Gemfile', /^gem\s\'sqlite3\'/, 'gem \'pg\''
  get_remote('config/database.yml.example', 'config/database.yml')
  gsub_file "config/database.yml", /myapp/, @app_name
end

# install gems
run 'bundle install --path vendor/bundle --jobs=4'

# create db
run 'bundle exec rails db:create'

# annotate gem
run 'rails g annotate:install'

# set config/application.rb
application  do
  %q{
    # Set timezone
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    # 日本語化
    I18n.available_locales = [:en, :ja]
    I18n.enforce_available_locales = true
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ja
    # generatorの設定
    config.generators do |g|
      g.orm :active_record
      g.template_engine :slim
      g.test_framework  :rspec, :fixture => true
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
      g.view_specs false
      g.controller_specs false
      g.routing_specs false
      g.helper_specs false
      g.request_specs false
      g.assets false
      g.helper false
    end
    # libファイルの自動読み込み
    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
  }
end

# For Bullet (N+1 Problem)
insert_into_file 'config/environments/development.rb',%(
  config.after_initialize do
    Bullet.enable = true # Bulletプラグインを有効
    Bullet.alert = true # JavaScriptでの通知
    Bullet.bullet_logger = true # log/bullet.logへの出力
    Bullet.console = true # ブラウザのコンソールログに記録
    Bullet.rails_logger = true # Railsログに出力
  end
), after: 'config.assets.debug = true'

# Japanese locale
run 'wget https://raw.github.com/svenfuchs/rails-i18n/master/rails/locale/ja.yml -P config/locales/'

# erb to slim
run 'gem install html2slim'
run 'bundle exec erb2slim -d app/views'
gsub_file 'app/views/layouts/application.html.slim', /,\s\'data-turbolinks-track\'\s=>\strue/, ''

# turbolinksの削除
gsub_file 'app/assets/javascripts/application.js', /\/\/=\srequire\sturbolinks\n/, ''

# Bootstrap
remove_file 'app/assets/stylesheets/application.css'
get_remote('app/assets/stylesheets/application.scss')
get_remote('app/assets/stylesheets/bootstrap-custom.scss')
get_remote('app/assets/stylesheets/reset.scss')

# Simple Form
generate 'simple_form:install --bootstrap'

# Whenever
run 'bundle exec wheneverize .'

# Capistrano
get_remote('Capfile')

# Deploy
get_remote('config/deploy.rb.example', 'config/deploy.rb')
gsub_file "config/deploy.rb", /my_repo/, @repo
run 'mkdir config/deploy'
get_remote('config/deploy/production.rb.example', 'config/deploy/production.rb')
gsub_file "config/deploy/production.rb", /myapp/, @app_name

# Unicorn
run 'mkdir -p lib/capistrano/tasks'
get_remote('config/unicorn.rb')
get_remote('lib/capistrano/tasks/unicorn.rake')

# Kaminari config
generate 'kaminari:config'

# Rspec
generate 'rspec:install'
run "echo '--color -f d' > .rspec"

# Guard
get_remote('Guardfile')

# git
git
git :init
git add: '.'
git commit: "-a -m 'rails new #{@app_name} -m https://raw.githubusercontent.com/Iwark/rails5_template/master/app_template.rb'"
