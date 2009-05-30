require File.dirname(__FILE__) + '/../spec_helper'

describe Highrise::Tag do

  before(:each) do
    Highrise::Base.site = 'http://example.com.i/'
    @tag = Highrise::Tag.new(:id => 1, :name => "Name")
  end
  
  it "should be instance of Highrise::Base" do
    @tag.kind_of?(Highrise::Base).should be_true
  end

  it "should support equality" do
    tag = Highrise::Tag.new(:id => 1, :name => "Name")
    @tag.should == tag
  end
  
  it "it should find_by_name" do
    tag = Highrise::Tag.new(:id => 2, :name => "Next")
    Highrise::Tag.should_receive(:find).with(:all).and_return([tag, @tag])
    Highrise::Tag.find_by_name("Name").should == @tag
  end
end
