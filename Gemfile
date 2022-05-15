# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 6.1.4'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Adds an authentication solution for users
gem 'devise'

# Enables soft deletion on model objects
gem 'discard', '~> 1.2'

# Loads environment vars into ENV
gem 'dotenv-rails'

# Provides Oauth 2 functionality
gem 'doorkeeper'

# Adds JWT support to doorkeeper
gem 'doorkeeper-jwt'

# Middlewarefor REST api
gem 'grape'

# Wrapper for reusable entities in our REST api
gem 'grape-entity'

# API routing generator
gem 'grape_on_rails_routes'

# Pagination service
gem 'grape-pagy'

# Use Postgres as the database for Active Record
gem 'pg'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

group :development, :test do
  # Adds schema annotations to models and related files
  gem 'annotate'

  # Debugging tool
  gem 'byebug'

  # Testing Framework
  gem 'rspec-rails'
end

group :development do
  # Analysis tool for detecting security vulnerabilities
  gem 'brakeman'
  # Spring speeds up development by keeping our application running in the
  # background
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # Static code analyzer
  gem 'rubocop', require: false

  # A RuboCop extension focused on enforcing Rails best practices and coding conventions.
  gem 'rubocop-rails', require: false

  # # Internal documentation library for API
  # gem 'grape-swagger'

  # # Swagger dependency for formatting Grape entities
  # gem 'grape-swagger-entity'

  # # Swagger UI library
  # gem 'grape-swagger-rails'

  # # Dependency for Swagger UI
  # gem 'sprockets-rails', require: 'sprockets/railtie'
end

group :test do
  # Cleans our test database to ensure a clean state in each test suite
  gem 'database_cleaner-active_record'

  # A fixtures replacement with a more straightforward syntax
  gem 'factory_bot_rails'

  # A library for generating fake data
  gem 'faker'

  # Provides RSpec with additional matchers
  gem 'shoulda-matchers'

  # Mocking for http
  gem 'webmock'
end
