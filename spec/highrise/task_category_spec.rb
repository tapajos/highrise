require File.dirname(__FILE__) + '/../spec_helper'

describe Highrise::TaskCategory do
  before(:each) do
    @task_category = Highrise::TaskCategory.new(:id => 1, :name => "Task Category")
  end
  
  it "should be instance of Highrise::Base" do
    @task_category.kind_of?(Highrise::Base).should be_true
  end
  
  it "it should find_by_name" do
    task_category = Highrise::TaskCategory.new(:id => 2, :name => "Another Task Category")
    Highrise::TaskCategory.should_receive(:find).with(:all).and_return([task_category, @task_category])
    Highrise::TaskCategory.find_by_name("Task Category").should == @task_category
  end
end
