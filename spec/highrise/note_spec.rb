require 'spec_helper'

describe Highrise::Note do
  subject { Highrise::Note.new(:id => 1) }
  
  it { should be_a_kind_of Highrise::Base }

  it_should_behave_like "a paginated class"
  
  it "#comments" do
    Highrise::Comment.should_receive(:find).with(:all, {:from=>"/notes/1/comments.xml"}).and_return("comments")
    subject.comments.should == "comments"
  end
end
