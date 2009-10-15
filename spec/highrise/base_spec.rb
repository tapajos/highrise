require File.dirname(__FILE__) + '/../spec_helper'

describe Highrise::Base do
  
  before(:each) do
    @base = Highrise::Base.new
  end
  
  it "should be instance of ActiveResource::Base" do
    @base.kind_of?(ActiveResource::Base).should be_true
  end
  
end
