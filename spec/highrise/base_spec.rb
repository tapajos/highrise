require 'spec_helper'

describe Highrise::Base do
  it { subject.should be_a_kind_of ActiveResource::Base }

  describe "dynamic finder methods" do
    context "without pagination" do
      before do
        @deal_one   = Highrise::Base.new(:id => 1, :name => "A deal")
        @deal_two   = Highrise::Base.new(:id => 2, :name => "A deal")
        @deal_three = Highrise::Base.new(:id => 3, :name => "Another deal")
        Highrise::Base.should_receive(:find).with(:all).and_return([@deal_one, @deal_two, @deal_three])
      end
      it ".find_by_(attribute) finds one" do
        Highrise::Base.find_by_name("A deal").should == @deal_one
      end

      it ".find_all_by_(attribute) finds all" do
        Highrise::Base.find_all_by_name("A deal").should == [@deal_one, @deal_two]
      end
    end

    context "with pagination" do
      before do
        class PaginatedBaseClass < Highrise::Base; include Highrise::Pagination; end
        @john_doe   = PaginatedBaseClass.new(:id => 1, :first_name => "John")
        @john_baker = PaginatedBaseClass.new(:id => 2, :first_name => "John")
        @joe_smith  = PaginatedBaseClass.new(:id => 3, :first_name => "Joe")
        PaginatedBaseClass.should_receive(:find_all_across_pages).and_return([@john_doe, @john_baker, @joe_smith])
      end
      it ".find_by_(attribute) finds one" do
        PaginatedBaseClass.find_by_first_name("John").should == @john_doe
      end

      it ".find_all_by_(attribute) finds all" do
        PaginatedBaseClass.find_all_by_first_name("John").should == [@john_doe, @john_baker]
      end
    end

    it "expects arguments to the finder" do
      expect { Highrise::Base.find_all_by_first_name }.to raise_error(ArgumentError)
    end

    it "falls back to regular method missing" do
      expect { Highrise::Base.any_other_method }.to raise_error(NoMethodError)
    end
  end

  describe "when using an oauth token" do
    it ".oauth_token= writes a bearer authorization header" do
      Highrise::Base.oauth_token = 'OAUTH_TOKEN'
      Highrise::Base.headers['Authorization'].should == 'Bearer OAUTH_TOKEN'
    end
  end
end