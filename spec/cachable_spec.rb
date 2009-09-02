require File.dirname(__FILE__) + '/spec_helper'

describe Highrise::Base, "class configuration" do
  before(:each) do
    Highrise::Base.site = 'http://example.com.i:3000'
  end
    
  it "should tell us if caching is active" do
    Highrise::Base.cache_store = ActiveSupport::Cache.lookup_store :memory_store
    Highrise::Base.is_caching?.should == true
  end
  
  it "should tell us if caching is not active" do
    Highrise::Base.cache_store = nil
    Highrise::Base.is_caching?.should == false
  end
end

describe Highrise::Base do
  before(:all) do
    Highrise::Base.site = 'http://example.com.i:3000'
    Highrise::Base.cache_store = ActiveSupport::Cache.lookup_store :memory_store
  end
  
  after(:all) do
    Highrise::Base.cache_store = :none
  end
  
  before(:each) do
    @thing = Highrise::Base.new
    @key = :key
    Highrise::Base.stub!(:cache_key).and_return(@key)
  end
  
  context "when a cached response is available" do
    before(:each) do
      Highrise::Base.cache_store.write(@key, @thing)
    end
    
    it "should NOT make a request to the RESTful server" do
      Highrise::Base.should_not_receive(:find_single_without_cache)
      Highrise::Base.find(1)
    end
    
    it "should read from the cache" do
      Highrise::Base.find(1).should == @thing
    end
  end
  
  context "when a cached response is NOT available" do
    before(:each) do
      Highrise::Base.cache_store.delete(@key)
    end
    
    it "SHOULD perform an ARes request" do
      Highrise::Base.should_receive(:find_single_without_cache).and_return(@thing)
      Highrise::Base.find(1)
    end
    
    it "should cache the response using the caching key" do
      Highrise::Base.should_receive(:find_single_without_cache).and_return(@thing)
      Highrise::Base.find(1)
      Highrise::Base.cache_store.read(@key).should == @thing
    end
  end
end