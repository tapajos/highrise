require 'bundler'
Bundler.setup

require File.join(File.dirname(__FILE__), '/../lib/highrise')

Highrise::Base.user = ENV['HIGHRISE_USER'] || 'x'
Highrise::Base.site = ENV['HIGHRISE_SITE'] || 'http://www.example.com'

shared_examples_for "a paginated class" do
  it { subject.class.included_modules.should include(Highrise::Pagination) }

  it ".find_all_across_pages" do
    subject.class.should_receive(:find).with(:all,{:params=>{:n=>0}}).and_return(["things"])
    subject.class.should_receive(:find).with(:all,{:params=>{:n=>1}}).and_return([])
    subject.class.find_all_across_pages.should == ["things"]
  end

  it ".find_all_across_pages_since" do
    time = Time.parse("Wed Jan 14 15:43:11 -0200 2009")
    subject.class.should_receive(:find_all_across_pages).with({:params=>{:since=>"20090114174311"}}).and_return("result")
    subject.class.find_all_across_pages_since(time).should == "result"
  end
  
end

shared_examples_for "a searchable class" do
  it { subject.class.included_modules.should include(Highrise::Searchable) }

  it ".search" do
    find_args = {:from => "/#{subject.class.collection_name}/search.xml", :params => {"criteria[email]" => "john.doe@example.com", "criteria[zip]" => "90210"}}
    if subject.class.respond_to?(:find_all_across_pages)
      subject.class.should_receive(:find_all_across_pages).with(find_args)
    else
      subject.class.should_receive(:find).with(:all, find_args)
    end
    subject.class.search(:email => "john.doe@example.com", :zip => "90210")
  end
end

shared_examples_for "a taggable class" do
  before(:each) do
    (@tags = []).tap do 
      @tags << {'id' => "414578", 'name' => "cliente"}
      @tags << {'id' => "414580", 'name' => "ged"}
      @tags << {'id' => "414579", 'name' => "iepc"}
    end
  end

  it { subject.class.included_modules.should include(Highrise::Taggable) }

  it "#tags" do
    subject.should_receive(:get).with(:tags).and_return(@tags)
    subject.tags.should == @tags
  end
  
  it "#tag!(tag_name)" do
    subject.should_receive(:post).with(:tags, :name => "client" ).and_return(true)
    subject.tag!("client").should be_true
  end
  
  it "#untag!(tag_name)" do
    subject.should_receive(:get).with(:tags).and_return(@tags)
    subject.should_receive(:delete).with("tags/414578").and_return(true)
    subject.untag!("cliente").should be_true
  end
end