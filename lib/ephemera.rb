require 'bcrypt'

module Ephemera
  mattr_accessor :encryption_cost
end

require 'ephemera/engine'
