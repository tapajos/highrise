require File.expand_path(File.dirname(__FILE__) + '/../cachable')

module Highrise
  class Base < ActiveResource::Base
  end
  include Cachable
end
