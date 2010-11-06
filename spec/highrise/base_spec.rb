require 'spec_helper'

describe Highrise::Base do
  it { subject.should be_a_kind_of ActiveResource::Base }

  describe "dynamic finder methods" do
    before(:each) do
      @john_doe = Highrise::Person.new(:id => 1, :first_name => "John", :last_name => "Doe")
      @john_baker = Highrise::Person.new(:id => 2, :first_name => "John", :last_name => "Baker")
      @joe_smith = Highrise::Person.new(:id => 3, :first_name => "Joe", :last_name => "Smith")
    end

    it "finds one when using find_by_(attribute)" do
      Highrise::Person.should_receive(:find).with(:all).and_return([@john_doe, @john_baker, @joe_smith])
      Highrise::Person.find_by_first_name("John").should == @john_doe
    end

    it "finds all when using find_all_by_(attribute)" do
      Highrise::Person.should_receive(:find).with(:all).and_return([@john_doe, @john_baker, @joe_smith])
      Highrise::Person.find_all_by_first_name("John").should == [@john_doe, @john_baker]
    end

    it "raises an argument when no arguments passed to method missing" do
      lambda { Highrise::Person.find_all_by_first_name }.should raise_error(ArgumentError)
    end

    it "falls back to regular method missing if method doesnt match regex" do
      lambda { Highrise::Person.any_other_method }.should raise_error(NoMethodError)
    end
  end
end