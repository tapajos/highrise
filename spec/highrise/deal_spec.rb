require 'spec_helper'

describe Highrise::Deal do
  subject { Highrise::Deal.new(:id => 1) }
    
  it { subject.should be_a_kind_of Highrise::Subject }
  
  it ".add_note" do
    Highrise::Note.should_receive(:create).with({:body=>"body", :subject_id=>1, :subject_type=>'Deal'}).and_return(mock('note'))
    subject.add_note :body=>'body'
  end
  
  describe ".update_status" do
    it { expect { subject.update_status("invalid") }.to raise_error(ArgumentError) }
    
      %w[pending won lost].each do |status|
        it "updates status to #{status}" do
        subject.should_receive(:put).with(:status, :status => {:name => status})
        subject.update_status(status)
      end
    end
  end
end