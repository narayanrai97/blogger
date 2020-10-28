source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.5.3'

gem 'rails', '~> 5.1.5'
gem 'pg',    '0.18.4'
gem 'puma',  ">= 3.12.2"
gem 'bootstrap-sass','3.4.1'
gem 'hirb'
gem 'will_paginate',           '3.1.6'
gem 'bootstrap-will_paginate', '1.0.0'
gem 'jquery-rails', '4.3.1'
gem 'turbolinks', '~> 5'
gem "paperclip", git: "https://github.com/thoughtbot/paperclip.git"
gem 'aws-sdk', '~> 2'
gem 'exponent-server-sdk'
gem 'sorcery'
gem 'impressionist', '~> 1.6'
gem 'grape'
gem 'rack-cors', :require => 'rack/cors'
gem 'grape-active_model_serializers'
gem 'grape_on_rails_routes'
gem 'grape-swagger', '0.11.0'
gem 'sass-rails',   '~> 5.0'
gem 'coffee-rails', '~> 4.2'
gem 'uglifier',     '>= 1.3.0'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'selenium-webdriver'
  gem 'rspec-rails'            # addedb
  gem 'listen', '3.1.5'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  # gem 'listen', '3.1.5'
  gem 'spring'
  # gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'factory_bot_rails'
  gem 'capybara'
  gem 'guard-rspec'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'rails-controller-testing'
