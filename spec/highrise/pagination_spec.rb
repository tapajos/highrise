require 'spec_helper'

describe Highrise::Pagination do
  subject { class TestClass < Highrise::Base; include Highrise::Pagination; end }
  
  it { subject.included_modules.should include(Highrise::Pagination) }
  
  it ".find_all_across_pages" do
    subject.should_receive(:find).with(:all,{:params=>{:n=>0}}).and_return(["things"])
    subject.should_receive(:find).with(:all,{:params=>{:n=>1}}).and_return([])
    subject.find_all_across_pages.should == ["things"]
  end
end
