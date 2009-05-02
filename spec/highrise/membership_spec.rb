require File.dirname(__FILE__) + '/../spec_helper'

describe Highrise::Membership do

  before(:each) do
    @member = Highrise::Membership.new
  end
  
  it "should be instance of Highrise::Base" do
    @member.kind_of?(Highrise::Base).should be_true
  end


end
