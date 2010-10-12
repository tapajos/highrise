require File.dirname(__FILE__) + '/../spec_helper'

describe Highrise::Deal do

  before(:each) do
    @deal = Highrise::Deal.new(:id => 1)
  end
  
  it "should be instance of Highrise::Subject" do
    @deal.kind_of?(Highrise::Subject).should be_true
  end
  
  describe ".add_note" do
    it "should delegate to Highrise::Note.create with correct params" do
      Highrise::Note.should_receive(:create).with({:body=>"body", :subject_id=>1, :subject_type=>'Deal'}).and_return(mock('note'))
      @deal.add_note :body=>'body'
    end
  end

  describe ".update_status" do
    it "should raise ArgumentError if status is invalid" do
      lambda { Highrise::Deal.update_status("invalid").should raise_error(ArgumentError) }
    end
    
    it "should update status to won" do
      @deal.should_receive(:put).with(:status, :status => {:name => "won"})
      @deal.update_status("won")
    end
  end
end
