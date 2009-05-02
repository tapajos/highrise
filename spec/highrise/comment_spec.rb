require File.dirname(__FILE__) + '/../spec_helper'

describe Highrise::Comment do

  before(:each) do
    @comment = Highrise::Comment.new
  end
  
  it "should be instance of Highrise::Base" do
    @comment.kind_of?(Highrise::Base).should be_true
  end


end
