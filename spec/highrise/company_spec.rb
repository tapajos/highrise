require File.dirname(__FILE__) + '/../../spec_helper'

describe Highrise::Company do

  before(:each) do
    @company = Highrise::Company.new
  end
  
  it "should be instance of Highrise::Base" do
    @company.kind_of?(Highrise::Base).should be_true
  end
  
  describe ".find_all_across_pages_since" do
    
    it "should delegate to find_all_across_pages with correct params" do
      time = Time.parse("Wed Jan 14 15:43:11 -0200 2009")
      Highrise::Company.should_receive(:find_all_across_pages).with({:params=>{:since=>"20090114174311"}}).and_return("result")
      Highrise::Company.find_all_across_pages_since(time).should == "result"
    end

  end
  
  describe "people" do

    it "should delegate to Highrise::Person.find with correct params" do
      @company.should_receive(:id).and_return(1)
      Highrise::Person.should_receive(:find).with(:all, {:from=>"/companies/1/people.xml"}).and_return("people")
      @company.people.should == "people"
    end

  end


end
