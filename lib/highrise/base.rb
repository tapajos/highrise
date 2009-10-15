require File.dirname(__FILE__) + '/../cachable'

module Highrise
  class Base < ActiveResource::Base
    include ::Cachable
  end
end
