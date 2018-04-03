source 'https://rubygems.org'

ruby '2.5.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'bcrypt'
gem 'jwt', '1.5.6'
gem 'money-rails'
gem 'nokogiri', require: false
gem 'pg'
gem 'puma'
gem 'rack-cors'
gem 'rails'

group :development, :test do
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
end

group :test do
  gem 'codeclimate-test-reporter', '~> 1.0.0'
  gem 'simplecov'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
