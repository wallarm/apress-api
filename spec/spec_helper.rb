require "bundler/setup"
require 'pry-byebug'

require "simplecov"
SimpleCov.start "rails" do
  minimum_coverage 98
  add_filter "/lib/apress/api/rspec"
  add_filter "/lib/apress/api/testing/"
  add_filter "/lib/apress/api/swagger/"
  add_filter "/app/docs"
end

require "rails-controller-testing"
require "apress/api"

require "factory_bot_rails"
require "timecop"
require "combustion"

Combustion.initialize! :all do
  config.cache_store = :null_store if defined?(ActiveSupport::Cache::NullStore)
end

require "rspec/rails"

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.use_transactional_fixtures = true
end
