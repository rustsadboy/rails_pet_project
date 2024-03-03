# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.0'

gem 'bcrypt', '~> 3.1.7'                    # Use Active Model has_secure_password
gem 'blueprinter'                           # JSON Object Presenter for Ruby
gem 'bootsnap', '>= 1.4.4', require: false
gem 'dotenv-rails'                          # Shim to load environment variables from .env into ENV in development.
gem 'draper'                                # Draper adds an object-oriented layer of presentation logic to your Rails application
gem 'dry-initializer'
gem 'dry-monads'
gem 'dry-validation'                        # Validation library with type-safe schemas and rules
gem 'factory_bot_rails'
gem 'faraday'
gem 'fcm'
gem 'i18n'
gem 'jwt'                                   # Rails-API authentication solution based on JWT
gem 'kaminari'                              # Pagination
gem 'listen', '~> 3.3'                      # Listen file changes
gem 'midilib'                               # a Ruby MIDI library useful for reading and writing standard MIDI files
gem 'oj'
gem 'openssl-additions', '~> 0.7.0'
gem 'pg', '~> 1.1'
gem 'pry'                                   # Powerful alternative to the standard IRB shell for Ruby
gem 'puma', '~> 5.0'
gem 'rails', '7.0.4.1'
gem 'redis'                                 # Use Redis adapter to run Action Cable in production
gem 'rspec'
gem 'rspec-rails'
gem 'rswag'
gem 'ruby2_keywords'
gem 'shoulda-matchers'
gem 'sidekiq'
gem 'sidekiq-scheduler'
gem 'vcr'
gem 'webmock'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'ffaker'
  gem 'rubocop-rails'
end

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  gem 'database_cleaner-active_record'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
