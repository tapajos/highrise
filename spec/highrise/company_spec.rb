require File.dirname(__FILE__) + '/../spec_helper'

describe Highrise::Company do

  before(:each) do
    Highrise::Base.site = 'http://example.com.i:3000'
    @company = Highrise::Company.new(:id => 1)
    returning @tags = [] do 
      @tags << {'id' => "414578", 'name' => "cliente"}
      @tags << {'id' => "414580", 'name' => "ged"}
      @tags << {'id' => "414579", 'name' => "iepc"}
    end
  end
  
  it "should be instance of Highrise::Base" do
    @company.kind_of?(Highrise::Base).should be_true
  end
  
  describe ".find_all_across_pages_since" do
    
    it "should delegate to find_all_across_pages with correct params" do
      time = Time.parse("Wed Jan 14 15:43:11 -0200 2009")
      Highrise::Company.should_receive(:find_all_across_pages).with({:params=>{:since=>"20090114174311"}}).and_return("result")
      Highrise::Company.find_all_across_pages_since(time).should == "result"
    end

  end
  
  describe "people" do

    it "should delegate to Highrise::Person.find with correct params" do
      @company.should_receive(:id).and_return(1)
      Highrise::Person.should_receive(:find).with(:all, {:from=>"/companies/1/people.xml"}).and_return("people")
      @company.people.should == "people"
    end

  end
  
  describe ".tags" do
    
    it "should return an array of all tags for that company." do
      @company.should_receive(:get).with(:tags).and_return(@tags)
      @company.tags.should == @tags
    end
    
  end
  
  describe "tag!(tag_name)" do
  
    it "should create a tag for this company." do
      @company.should_receive(:post).with(:tags, :name => "client" ).and_return(true)
      @company.tag!("client").should be_true
    end
    
  end
  
  describe "untag!(tag_name)" do
  
    it "should delete a tag for this company." do
      @company.should_receive(:get).with(:tags).and_return(@tags)
      @company.should_receive(:delete).with("tags/414578").and_return(true)
      @company.untag!("cliente").should be_true
    end
    
  end


end
