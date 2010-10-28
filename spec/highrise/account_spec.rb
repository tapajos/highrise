require 'spec_helper'

describe Highrise::Account do
  it { should be_a_kind_of Highrise::Base }
  
  it ".me" do
    Highrise::Account.should_receive(:find).with(:one, {:from => "/account.xml"}).and_return(subject)
    Highrise::Account.me.should == subject
  end
end
