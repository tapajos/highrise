require File.dirname(__FILE__) + '/../spec_helper'

describe Highrise::Kase do

  before(:each) do
    @kase = Highrise::Kase.new
  end
  
  it "should be instance of Highrise::Subject" do
    @kase.kind_of?(Highrise::Subject).should be_true
  end
  
  describe ".close!" do

    it "should set close date and save" do
      time = Time.parse("Wed Jan 14 15:43:11 -0200 2009")
      Time.should_receive(:now).and_return(time)
      @kase.should_receive(:closed_at=).with(time.utc)
      @kase.should_receive(:save)
      @kase.close!
    end

  end

end
