require 'spec_helper'

describe Highrise::Recording do
  it { should be_a_kind_of Highrise::Base }

  it_should_behave_like "a paginated class"
  
  it ".find_all_across_pages_since" do
    time = Time.parse("Wed Jan 14 15:43:11 -0200 2009")
    Highrise::Recording.should_receive(:find_all_across_pages).with({:params=>{:since=>"20090114174311"}}).and_return("result")
    Highrise::Recording.find_all_across_pages_since(time).should == "result"
  end
end