require 'bundler'

Bundler.setup :default, :development

require 'rails'
require 'combustion'
require 'ephemera'

Combustion.initialize! :active_record

require 'rspec/rails'

Ephemera.encryption_cost = 1

RSpec.configure do |config|
  config.use_transactional_fixtures = true
end
