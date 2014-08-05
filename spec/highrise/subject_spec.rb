require 'spec_helper'

describe Highrise::Subject do
  subject { Highrise::Subject.new(:id => 1) }

  it { should be_a_kind_of Highrise::Base }

  it "#notes" do
    Highrise::Note.should_receive(:find_all_across_pages).with({:from=>"/subjects/1/notes.xml"}).and_return("notes")
    subject.notes.should == "notes"
  end

  it "#add_note" do
    Highrise::Note.should_receive(:create).with({:body=>"body", :subject_id=>1, :subject_type=>'Subject'}).and_return(mock('note'))
    subject.add_note :body=>'body'
  end
  
  it "#add_task" do
    Highrise::Task.should_receive(:create).with({:body=>"body", :subject_id=>1, :subject_type=>'Subject'}).and_return(mock('task'))
    subject.add_task :body=>'body'
  end

  it "#emails" do
    Highrise::Email.should_receive(:find_all_across_pages).with({:from=>"/subjects/1/emails.xml"}).and_return("emails")
    subject.emails.should == "emails"
  end

  it "#upcoming_tasks" do
    Highrise::Task.should_receive(:find).with(:all, {:from=>"/subjects/1/tasks.xml"}).and_return("tasks")
    subject.upcoming_tasks.should == "tasks"
  end

  context 'finding with since param' do
    before(:each) do
      @utc_time_str = "20090114174311"
    end

    it "#notes" do
      Highrise::Note.should_receive(:find_all_across_pages).with({:from=>"/subjects/1/notes.xml", :params=>{:since=>@utc_time_str}}).and_return("notes")
      subject.notes(:params=>{:since=>@utc_time_str}).should == "notes"
    end

    it "#emails" do
      Highrise::Email.should_receive(:find_all_across_pages).with({:from=>"/subjects/1/emails.xml", :params=>{:since=>@utc_time_str}}).and_return("emails")
      subject.emails(:params=>{:since=>@utc_time_str}).should == "emails"
    end


    it "#tasks" do
      Highrise::Task.should_receive(:find).with(:all, {:from=>"/subjects/1/tasks.xml", :params=>{:since=>@utc_time_str}}).and_return("tasks")
      subject.upcoming_tasks(:params=>{:since=>@utc_time_str}).should == "tasks"
    end
  end
  
  it { subject.label.should == "Subject" }
end