require File.dirname(__FILE__) + '/../spec_helper'

describe Highrise::Group do

  before(:each) do
    @group = Highrise::Group.new
  end
  
  it "should be instance of Highrise::Base" do
    @group.kind_of?(Highrise::Base).should be_true
  end


end
