require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Backend
  class Application < Rails::Application
    config.load_defaults 7.0
    config.api_only = true
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'localhost:3000'
        resource '*',
          headers: :any,
          methods: [:get, :post, :put, :patch, :delete, :options, :head]
      end
    end
    config.generators.test_framework = :rspec
    config.generators.system_tests   = false
    config.generators.helper         = false
  end
end
