require 'bcrypt'
require 'rack'

module Ephemera
  mattr_accessor :encryption_cost, :request_header, :timeout
end

Ephemera.encryption_cost = 10
Ephemera.request_header  = 'Authentication'
Ephemera.timeout         = 14.days

require 'ephemera/engine'
require 'ephemera/request'
