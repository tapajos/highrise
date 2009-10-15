require File.dirname(__FILE__) + '/../spec_helper'

describe Highrise::Email do

  before(:each) do
    @mail = Highrise::Email.new
  end
  
  it "should be instance of Highrise::Base" do
    @mail.kind_of?(Highrise::Base).should be_true
  end
  
  describe "comments" do

    it "should delegate to Highrise::Comment.find with correct params" do
      @mail.should_receive(:email_id).and_return(1)
      Highrise::Comment.should_receive(:find).with(:all, {:from=>"/emails/1/comments.xml"}).and_return("comments")
      @mail.comments.should == "comments"
    end

  end
  


end
