require 'spec_helper'

describe Highrise::Searchable do
  class TestClass < Highrise::Base; include Highrise::Searchable; end
  subject { TestClass.new }
  
  it_should_behave_like "a searchable class"
end
