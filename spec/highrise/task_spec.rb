require File.dirname(__FILE__) + '/../spec_helper'

describe Highrise::Task do

  before(:each) do
    @task = Highrise::Task.new
  end
  
  it "should be instance of Highrise::Base" do
    @task.kind_of?(Highrise::Base).should be_true
  end
  
  describe ".complete!" do
    
    it "should delegate to load_attributes_from_response" do
      @task.should_receive(:load_attributes_from_response).with("post")
      @task.should_receive(:post).with(:complete).and_return("post")
      @task.complete!
    end

  end

end
