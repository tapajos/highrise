require 'spec_helper'

describe Highrise::Company do
  subject { Highrise::Company.new(:id => 1) }
  
  it { should be_a_kind_of Highrise::Base }
  it_should_behave_like "a paginated class"
  it_should_behave_like "a taggable class"

  it ".find_all_across_pages_since" do
    time = Time.parse("Wed Jan 14 15:43:11 -0200 2009")
    Highrise::Company.should_receive(:find_all_across_pages).with({:params=>{:since=>"20090114174311"}}).and_return("result")
    Highrise::Company.find_all_across_pages_since(time).should == "result"
  end
  
  it "#people" do
    Highrise::Person.should_receive(:find_all_across_pages).with(:from=>"/companies/1/people.xml").and_return("people")
    subject.people.should == "people"
  end
  
  it { subject.label.should == 'Party' }
end
