require 'spec_helper'

describe Highrise::Pagination do
  class TestClass < Highrise::Base; include Highrise::Pagination; end
  subject { TestClass.new }
  
  it_should_behave_like "a paginated class"
end
