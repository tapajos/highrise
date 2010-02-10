require File.dirname(__FILE__) + '/../spec_helper'

describe Highrise::Subject do

  before(:each) do
    @subject = Highrise::Subject.new(:id => 1)
  end

  it "should be instance of Highrise::Base" do
    @subject.kind_of?(Highrise::Base).should be_true
  end

  describe ".notes" do
    it "should delegate to Highrise::Note with correct params" do      Highrise::Note.should_receive(:find_all_across_pages).with({:from=>"/subjects/1/notes.xml"}).and_return("notes")
      @subject.notes.should == "notes"
    end
  end

  describe ".add_note" do
    it "should delegate to Highrise::Note.create with correct params" do
      Highrise::Note.should_receive(:create).with({:body=>"body", :subject_id=>1, :subject_type=>'Subject'}).and_return(mock('note'))
      @subject.add_note :body=>'body'
    end
  end

  describe ".emails" do
    it "should delegate to Highrise::Email with correct params" do
      Highrise::Email.should_receive(:find_all_across_pages).with({:from=>"/subjects/1/emails.xml"}).and_return("emails")
      @subject.emails.should == "emails"
    end
  end


  describe ".upcoming_tasks" do

    it "should delegate to Highrise::Task with correct params" do
      Highrise::Task.should_receive(:find).with(:all, {:from=>"/subjects/1/tasks.xml"}).and_return("tasks")
      @subject.upcoming_tasks.should == "tasks"
    end

  end
  
  describe ".label" do
    it "should return the class name as a string" do
      @subject.label.should == "Subject"
    end
  end

end