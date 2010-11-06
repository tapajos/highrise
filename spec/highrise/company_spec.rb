require 'spec_helper'

describe Highrise::Company do
  subject { Highrise::Company.new(:id => 1) }
  
  it { should be_a_kind_of Highrise::Base }
  it_should_behave_like "a paginated class"
  it_should_behave_like "a taggable class"
  it_should_behave_like "a searchable class"

  it "#people" do
    Highrise::Person.should_receive(:find_all_across_pages).with(:from=>"/companies/1/people.xml").and_return("people")
    subject.people.should == "people"
  end
  
  it { subject.label.should == 'Party' }
end
