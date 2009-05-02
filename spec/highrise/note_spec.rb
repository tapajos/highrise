require File.dirname(__FILE__) + '/../spec_helper'

describe Highrise::Note do

  before(:each) do
    @note = Highrise::Note.new
  end
  
  it "should be instance of Highrise::Base" do
    @note.kind_of?(Highrise::Base).should be_true
  end
  
  describe "comments" do

    it "should delegate to Highrise::Comment.find with correct params" do
      @note.should_receive(:id).and_return(1)
      Highrise::Comment.should_receive(:find).with(:all, {:from=>"/notes/1/comments.xml"}).and_return("comments")
      @note.comments.should == "comments"
    end

  end
  
end
