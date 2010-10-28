require 'spec_helper'

describe Highrise::Company do
  subject { Highrise::Company.new(:id => 1) }
  before(:each) do
    (@tags = []).tap do 
      @tags << {'id' => "414578", 'name' => "cliente"}
      @tags << {'id' => "414580", 'name' => "ged"}
      @tags << {'id' => "414579", 'name' => "iepc"}
    end
  end
  
  it { subject.should be_a_kind_of Highrise::Base }
  it { subject.class.included_modules.should include(Highrise::Pagination) }
  it { subject.class.included_modules.should include(Highrise::Taggable) }

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

  it ".add_note" do
    Highrise::Note.should_receive(:create).with({:body=>"body", :subject_id=>1, :subject_type=>'Party'}).and_return(mock('note'))
    subject.add_note :body=>'body'
  end
end
