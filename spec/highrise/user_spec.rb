require 'spec_helper'

describe Highrise::User do
  it { subject.should be_a_kind_of Highrise::Base }
  
  it ".me" do
    Highrise::User.should_receive(:find).with(:one, {:from => "/me.xml"}).and_return(subject)
    Highrise::User.me.should == subject
  end
  
  it "#join" do
    group_mock = mock("group")
    group_mock.should_receive(:id).and_return(2)
    subject.should_receive(:id).and_return(1)
    Highrise::Membership.should_receive(:create).with({:user_id=>1, :group_id=>2})
    subject.join(group_mock)
  end
end
