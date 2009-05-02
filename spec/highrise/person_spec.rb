require File.dirname(__FILE__) + '/../spec_helper'

describe Highrise::Person do

  before(:each) do
    Highrise::Base.site = 'http://example.com.i:3000'
    @person = Highrise::Person.new
    returning @tags = [] do 
      @tags << Highrise::Tag.new(:id => "414578", :name => "cliente")
      @tags << Highrise::Tag.new(:id => "414587", :name => "walk")
    end
  end
  
  it "should be instance of Highrise::Subject" do
    @person.kind_of?(Highrise::Subject).should be_true
  end
  
  describe ".find_all_across_pages_since" do
    
    it "should delegate to find_all_across_pages with correct params" do
      time = Time.parse("Wed Jan 14 15:43:11 -0200 2009")
      Highrise::Person.should_receive(:find_all_across_pages).with({:params=>{:since=>"20090114174311"}}).and_return("result")
      Highrise::Person.find_all_across_pages_since(time).should == "result"
    end

  end
  
  describe ".company" do

    it "should return nil when doesn't have company_id" do
      @person.should_receive(:company_id).and_return(nil)
      @person.company.should be_nil
    end

    it "should delegate to Highrise::Company when have company_id" do
      @person.should_receive(:company_id).at_least(2).times.and_return(1)
      Highrise::Company.should_receive(:find).with(1).and_return("company")
      @person.company.should == "company"
    end

  end
  
  describe ".name" do

    it "should concat fist_name with last_name and strip" do
      @person.should_receive(:first_name).and_return("Marcos")
      @person.should_receive(:last_name).and_return("Tapajós     ")
      @person.name.should == "Marcos Tapajós"
    end

  end
  
  describe ".tags" do
    
    it "should return an array of all tags for that user." do
      file_path = File.dirname(__FILE__) + "/people/16887003.html"
      @person.stub!(:get_document).and_return(Hpricot(File.open(file_path,"r"){|f| f.read}))
      @person.tags.should == @tags
    end
    
  end
  
  describe "tag!(tag_name)" do
  
    it "should create a tag for this user." do
      @person.should_receive(:post).with(:tags, :name => "Forum_User" ).at_least(1).times.and_return(true)
      @person.tag!("Forum_User").should be_true
    end
    
  end
  
  describe "untag!(tag_name)" do
  
    it "should delete a tag for this user." do
      file_path = File.dirname(__FILE__) + "/people/16887003.html"
      @person.stub!(:get_document).and_return(Hpricot(File.open(file_path,"r"){|f| f.read}))
      @person.should_receive(:delete).with("tags/414578").at_least(1).times.and_return(true)
      @person.untag!("cliente").should be_true
    end
    
  end
  
end
