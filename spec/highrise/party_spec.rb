require 'spec_helper'

describe Highrise::Party do
  it { should be_a_kind_of Highrise::Base }

  it ".recently_viewed" do
    Highrise::Party.should_receive(:find).with(:all, {:from => '/parties/recently_viewed.xml'})
    Highrise::Party.recently_viewed
  end
  
  it ".deletions_since" do
    time = Time.parse("Wed Jan 14 15:43:11 -0200 2009")
    Highrise::Party.should_receive(:find).with(:all, {:from => '/parties/deletions.xml', :params=>{:since=>"20090114174311"}}).and_return("result")
    Highrise::Party.deletions_since(time).should == "result"
  end
end