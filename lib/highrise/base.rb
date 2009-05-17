require File.dirname(__FILE__) + '/../cachable'

module Highrise
  class Base < ActiveResource::Base
  end
  class ActiveResource::Connection
    include Cachable
  end
end
