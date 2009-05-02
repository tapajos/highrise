require File.dirname(__FILE__) + '/../spec_helper'

describe Highrise::VERSION do
  it "should return a version string" do
    Highrise::VERSION::STRING.should =~ /\d+\.\d+\.\d+/
  end
  
  it "should return a MAJOR version" do
    Highrise::VERSION::MAJOR.class.should be(0.class)
  end
    
  it "should return a MINOR version" do
    Highrise::VERSION::MINOR.class.should be(0.class)
  end

  it "should return a TINY version" do
    Highrise::VERSION::TINY.class.should be(0.class)
  end
end