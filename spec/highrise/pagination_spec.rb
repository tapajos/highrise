require File.dirname(__FILE__) + '/../spec_helper'

describe Highrise::Pagination do
  
  it "should be tested" do
    Highrise::Person.should_receive(:find).with(:all,{:params=>{:n=>0}}).and_return(["people"])
    Highrise::Person.should_receive(:find).with(:all,{:params=>{:n=>1}}).and_return([])
    Highrise::Person.find_all_across_pages.should == ["people"]
  end
end
