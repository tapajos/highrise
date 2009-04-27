require File.dirname(__FILE__) + '/../../spec_helper'

describe Highrise::Tag do

  before(:each) do
    Highrise::Base.site = 'http://example.com.i/'
    @tag = Highrise::Tag.new
  end
  
  it "should be instance of Highrise::Base" do
    @tag.kind_of?(Highrise::Base).should be_true
  end

  it "should support equality" do
    @tag.id = 1
    @tag.name = "Name"
    
    tag = Highrise::Tag.new(:id => 1, :name => "Name")
    @tag.should == tag
  end
end
