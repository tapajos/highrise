require File.dirname(__FILE__) + '/../spec_helper'

describe Highrise::User do

  before(:each) do
    @user = Highrise::User.new
  end
  
  it "should be instance of Highrise::Base" do
    @user.kind_of?(Highrise::Base).should be_true
  end
  
  it "should delegate to find(:one, :from => '/me.xml') when me is called" do
    Highrise::User.should_receive(:find).with(:one, {:from => "/me.xml"}).and_return(@user)
    Highrise::User.me.should == @user
  end
  
  def join(group)
    Membership.create(:user_id => id, :group_id => group.id)
  end
  
  describe ".join" do

    it "should delegate to Highrise::Membership.create" do
      group_mock = mock("group")
      group_mock.should_receive(:id).and_return(2)
      @user.should_receive(:id).and_return(1)
      Highrise::Membership.should_receive(:create).with({:user_id=>1, :group_id=>2})
      @user.join(group_mock)
    end

  end


end
