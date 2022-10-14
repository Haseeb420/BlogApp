# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
ruby '2.7.2'
gem 'rails', '~> 5.2.8', '>= 5.2.8.1'
gem 'pg'
gem 'sass-rails', '~> 5.0'
gem 'terser', '~> 1.1', '>= 1.1.12'
gem 'coffee-rails', '~> 4.2'
gem 'bootstrap', '~> 5.2'
gem 'jquery-rails', '~> 4.5'
gem 'jquery-turbolinks', '~> 2.1'
gem 'popper_js', '~> 2.11', '>= 2.11.5'
gem 'trix-rails', require: 'trix'
gem 'turbolinks', '~> 5'
gem 'devise', '~> 4.8', '>= 4.8.1'
gem 'font-awesome-sass', '~> 6.2.0'
gem 'jbuilder', '~> 2.5'
gem 'nokogiri'
gem 'premailer-rails'
gem 'rack-cors'
gem 'cloudinary'
gem 'kaminari'
gem 'mini_magick', '~> 4.8'
gem 'rails_admin'
gem 'active_model_serializers', '~> 0.10.13'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'figaro', '~> 1.2'
gem 'activestorage-validator'
gem 'pundit'
gem 'rails_admin_pundit', github: 'sudosu/rails_admin_pundit'
group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 5.1', '>= 5.1.2'
  gem 'rubocop'

  gem 'rubocop-minitest'
  gem 'rubocop-packaging'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rake'
  gem 'rubocop-rspec'
  gem 'simplecov', require: false
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  gem 'solargraph', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'rails-controller-testing'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'faker'

end

