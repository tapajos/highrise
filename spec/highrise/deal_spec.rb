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

end
