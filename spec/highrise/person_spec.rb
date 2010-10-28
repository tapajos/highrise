# encoding: utf-8
require 'spec_helper'

describe Highrise::Person do
  subject { Highrise::Person.new(:id => 1) }
  
  it { subject.should be_a_kind_of Highrise::Subject }
  it { subject.class.included_modules.should include(Highrise::Pagination) }
  it { subject.class.included_modules.should include(Highrise::Taggable) }

  it ".find_all_across_pages_since" do
    mocked_now = Time.parse("Wed Jan 14 15:43:11 -0200 2009")
    Highrise::Person.should_receive(:find_all_across_pages).with({:params=>{:since=>"20090114174311"}}).and_return("result")
    Highrise::Person.find_all_across_pages_since(mocked_now).should == "result"
  end
  
  describe "#company" do
    it "returns nil when it doesn't have a company" do
      subject.should_receive(:company_id).and_return(nil)
      subject.company.should be_nil
    end

    it "delegate to Highrise::Company when have company_id" do
      subject.should_receive(:company_id).at_least(2).times.and_return(1)
      Highrise::Company.should_receive(:find).with(1).and_return("company")
      subject.company.should == "company"
    end
  end
  
  it "#name" do
    subject.should_receive(:first_name).and_return("Marcos")
    subject.should_receive(:last_name).and_return("Tapajós     ")
    subject.name.should == "Marcos Tapajós"
  end
  
  it { subject.label.should == 'Party' }
  
  it "#add_note" do
    Highrise::Note.should_receive(:create).with({:body=>"body", :subject_id=>1, :subject_type=>'Party'}).and_return(mock('note'))
    subject.add_note :body=>'body'
  end  
end
