require 'spec_helper'

describe Highrise::Taggable do
  class TestClass < Highrise::Base; include Highrise::Taggable; end
  
  subject { TestClass.new }
  
  it_should_behave_like "a taggable class"
end
