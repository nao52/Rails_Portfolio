source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem "rails",                      "7.0.4"
gem "image_processing",           "1.12.2"
gem "active_storage_validations", "0.9.8"
gem "bcrypt",                     "3.1.18"
gem "kaminari"
gem 'sass-rails',                 '>= 3.2'
gem 'bootstrap-sass',             '~> 3.3.6'
gem 'sassc',                      '2.1.0'
gem "sprockets-rails",            "3.4.2"
gem "importmap-rails",            "1.1.0"
gem "turbo-rails",                "1.1.1"
gem "stimulus-rails",             "1.0.4"
gem "jbuilder",                   "2.11.5"
gem "puma",                       "5.6.4"
gem "bootsnap",                   "1.12.0", require: false
gem "rails-i18n"

group :development, :test do
  gem "debug",   "1.5.0", platforms: %i[ mri mingw x64_mingw ]
  gem "rspec-rails", "~> 6.0.0"
  gem "spring-commands-rspec"
  gem "factory_bot_rails"
end

group :development do
  gem "mysql2"
  gem "web-console", "4.2.0"
  gem 'pre-commit'
  gem 'rubocop'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
end

group :test do
  gem "sqlite3", "1.4.2"
  gem "capybara",                 "3.37.1"
  gem "selenium-webdriver",       "4.2.0"
  gem "webdrivers",               "5.0.0"
  gem "rails-controller-testing", "1.0.5"
  gem "minitest",                 "5.15.0"
  gem "minitest-reporters",       "1.5.0"
  gem "guard",                    "2.18.0"
  gem "guard-minitest",           "2.4.6"
end

group :production do
  gem "mysql2"
  gem 'unicorn'
end
