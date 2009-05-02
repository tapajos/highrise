require 'lib/cachable'

module Highrise
  class Base < ActiveResource::Base
  end
  include Cachable
end