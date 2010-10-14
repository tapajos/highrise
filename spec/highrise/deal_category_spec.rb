require File.dirname(__FILE__) + '/../spec_helper'

describe Highrise::DealCategory do
  before(:each) do
    @deal_category = Highrise::DealCategory.new(:id => 1, :name => "Deal Category")
  end
  
  it "should be instance of Highrise::Base" do
    @deal_category.kind_of?(Highrise::Base).should be_true
  end
  
  it "it should find_by_name" do
    deal_category = Highrise::DealCategory.new(:id => 2, :name => "Another Deal Category")
    Highrise::DealCategory.should_receive(:find).with(:all).and_return([deal_category, @deal_category])
    Highrise::DealCategory.find_by_name("Deal Category").should == @deal_category
  end
end
