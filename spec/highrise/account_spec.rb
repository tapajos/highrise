require File.dirname(__FILE__) + '/../spec_helper'

describe Highrise::Account do
  before(:each) do
    @account = Highrise::Account.new
  end
  
  it "should be instance of Highrise::Base" do
    @account.kind_of?(Highrise::Base).should be_true
  end
  
  it "should delegate to find(:one, :from => '/account.xml') when account is called" do
    Highrise::Account.should_receive(:find).with(:one, {:from => "/account.xml"}).and_return(@account)
    Highrise::Account.me.should == @account
  end
end
