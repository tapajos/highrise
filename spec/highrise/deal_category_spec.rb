require 'spec_helper'

describe Highrise::DealCategory do
  subject { Highrise::DealCategory.new(:id => 1, :name => "Deal Category") }
  
  it { should be_a_kind_of Highrise::Base }
  
  it ".find_by_name" do
    deal_category = Highrise::DealCategory.new(:id => 2, :name => "Another Deal Category")
    Highrise::DealCategory.should_receive(:find).with(:all).and_return([deal_category, subject])
    Highrise::DealCategory.find_by_name("Deal Category").should == subject
  end
end
