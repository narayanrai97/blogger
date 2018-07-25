source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.5'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass','3.3.7'
gem 'hirb'
gem 'will_paginate',           '3.1.6'
gem 'bootstrap-will_paginate', '1.0.0'

gem 'uglifier', '>= 1.3.0'
# gem 'therubyracer', platforms: :ruby

gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails', '4.3.1'
gem 'turbolinks', '~> 5'
# gem 'jbuilder', '~> 2.5'
# gem 'redis', '~> 4.0'
# gem 'bcrypt', '~> 3.1.7'
gem "paperclip", git: "git://github.com/thoughtbot/paperclip.git"
gem 'sorcery'
gem 'impressionist', '~> 1.6'

# gem 'capistrano-rails', group: :development
gem 'grape'
gem 'rack-cors', :require => 'rack/cors'
gem 'grape-active_model_serializers'
gem 'grape_on_rails_routes'
gem 'grape-swagger'

# Paging
# gem 'kaminari'

group :development, :test do
  gem 'sqlite3',  '1.3.13'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'selenium-webdriver'
  gem 'rspec-rails' # added
  
  # gem 'guard-spork',  '1.2.0'
  # gem 'childprocess', '0.3.6'
  # gem 'spork',        '0.9.2'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '2.3.0'
end

group :production do
  gem 'pg', '0.18.4'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
