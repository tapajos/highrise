require File.dirname(__FILE__) + '/../spec_helper'

describe Highrise::DealCategory do

  before(:each) do
    @deal_category = Highrise::DealCategory.new
  end
  
  it "should be instance of Highrise::Base" do
    @deal_category.kind_of?(Highrise::Base).should be_true
  end
end
