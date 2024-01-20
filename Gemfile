source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"
gem "rails", "= 7.0.5"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i(mingw mswin x64_mingw jruby)
gem "bootsnap", require: false
gem "image_processing", "~> 1.2"
gem "active_storage_validations"
gem "aws-sdk-s3", require: false
gem "devise"
gem "devise-i18n"
gem "rails-i18n"
gem "chartkick"
gem "groupdate"
gem 'simple_calendar'

group :development, :test do
  gem "debug", platforms: %i(mri mingw x64_mingw)
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker"
  gem "rubocop-airbnb"
  gem "pry-rails"
end

group :test do
  gem "capybara"
end

group :development do
  gem "web-console"
end
