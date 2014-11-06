source 'https://rubygems.org'

ruby '2.1.3'

# dotenv has a load order dependancy :(
# it must be at the top
gem 'dotenv-rails', groups: [:development, :test]

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.4'
gem 'rails-api'
gem 'pg'
gem 'faraday'
gem 'faraday_middleware'
gem 'multi_xml'
gem 'thin'
gem 'hashie'
gem 'pry'

group :test, :development do
  gem 'factory_girl_rails'
end


group :test do
  gem 'vcr'
  gem 'rspec-rails', '~> 3.0.0.beta'
  gem 'database_cleaner'
  gem 'webmock'
  gem 'capybara'
  gem 'poltergeist'
end




# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano', :group => :development

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
