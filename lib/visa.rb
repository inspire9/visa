require 'bcrypt'
require 'rack'

module Visa
  mattr_accessor :encryption_cost, :request_header, :timeout
end

Visa.encryption_cost = 10
Visa.request_header  = 'HTTP_AUTHENTICATION'
Visa.timeout         = 14.days

require 'visa/engine'
require 'visa/request'
