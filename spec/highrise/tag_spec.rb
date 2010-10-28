require 'spec_helper'

describe Highrise::Tag do
  subject { Highrise::Tag.new(:id => 1, :name => "Name") }
  
  it { subject.should be_a_kind_of Highrise::Base }

  it "supports equality" do
    tag = Highrise::Tag.new(:id => 1, :name => "Name")
    subject.should == tag
  end
  
  it "#find_by_name" do
    tag = Highrise::Tag.new(:id => 2, :name => "Next")
    Highrise::Tag.should_receive(:find).with(:all).and_return([tag, subject])
    Highrise::Tag.find_by_name("Name").should == subject
  end
end
