require File.dirname(__FILE__) + '/spec_helper'

describe Highrise::Base, "class configuration" do
  before(:each) do
    Highrise::Base.site = 'http://example.com.i:3000'
    @connection = Highrise::Base.connection
  end
    
  it "should tell us if caching is active" do
    @connection.cache_store = ActiveSupport::Cache.lookup_store :memory_store
    @connection.is_caching?.should == true
  end
  
  it "should tell us if caching is not active" do
    @connection.cache_store = nil
    @connection.is_caching?.should == false
  end
end

describe Highrise::Base do
  before(:all) do
    Highrise::Base.site = 'http://example.com.i:3000'
    @connection = Highrise::Base.connection
    @connection.cache_store = ActiveSupport::Cache.lookup_store :memory_store
  end
  
  after(:all) do
    @connection.cache_store = :none
  end
  
  before(:each) do
    @thing = Highrise::Base.new
    @key = :key
    @connection.stub!(:cache_key).and_return(@key)
  end
  
  context "when a cached response is available" do
    before(:each) do
      @connection.cache_store.write(@key, @thing.attributes)
    end
    
    it "should NOT make a request to the RESTful server" do
      ActiveResource::Connection.should_not_receive(:get_without_cache)
      Highrise::Base.find(1)
    end
    
    it "should read from the cache" do
      Highrise::Base.find(1).should == @thing
    end
  end
  
  context "when a cached response is NOT available" do
    before(:each) do
      @connection.cache_store.delete(@key)
    end
    
    it "SHOULD perform an ARes request" do
      @connection.should_receive(:get_without_cache).and_return(@thing.attributes)
      Highrise::Base.find(1)
    end
    
    it "should cache the response using the caching key" do
      @connection.should_receive(:get_without_cache).and_return(@thing.attributes)
      Highrise::Base.find(1)
      @connection.cache_store.read(@key).should == @thing.attributes
    end
  end
end