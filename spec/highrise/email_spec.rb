require 'spec_helper'

describe Highrise::Email do
  it { should be_a_kind_of Highrise::Base }

  it_should_behave_like "a paginated class"
  
  it "#comments" do
    subject.should_receive(:id).and_return(1)
    Highrise::Comment.should_receive(:find).with(:all, {:from=>"/emails/1/comments.xml"}).and_return("comments")
    subject.comments.should == "comments"
  end
end
