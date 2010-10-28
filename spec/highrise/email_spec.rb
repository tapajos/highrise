require 'spec_helper'

describe Highrise::Email do
  it { subject.should be_a_kind_of Highrise::Base }
  it { subject.class.included_modules.should include(Highrise::Pagination) }
  
  it "#comments" do
    subject.should_receive(:email_id).and_return(1)
    Highrise::Comment.should_receive(:find).with(:all, {:from=>"/emails/1/comments.xml"}).and_return("comments")
    subject.comments.should == "comments"
  end
end
