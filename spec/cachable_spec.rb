require File.dirname(__FILE__) + '/spec_helper'

class CachedResource < ActiveResource::Base
  include ::Cachable
end

describe CachedResource, "class configuration" do
  before(:each) do
    CachedResource.site = 'http://example.com.i:3000'
  end
    
  it "should tell us if caching is active" do
    CachedResource.connection.cache_store = ActiveSupport::Cache.lookup_store :memory_store
    CachedResource.connection.is_caching?.should == true
  end
  
  it "should tell us if caching is not active" do
    CachedResource.connection.cache_store = nil
    CachedResource.connection.is_caching?.should == false
  end
end

describe CachedResource do
  before(:all) do
    CachedResource.site = 'http://example.com.i:3000'
    CachedResource.connection.cache_store = ActiveSupport::Cache.lookup_store :memory_store
  end
  
  after(:all) do
    CachedResource.connection.cache_store = :none
  end
  
  before(:each) do
    @thing = CachedResource.new(:id => 1)
    @key = :key
    CachedResource.connection.stub!(:cache_key).and_return(@key)
  end
  
  context "when a cached response is available" do
    before(:each) do
      CachedResource.connection.cache_store.write(@key, @thing.attributes)
    end
    
    it "should NOT make a request to the RESTful server" do
      CachedResource.connection.should_not_receive(:get_without_cache)
      CachedResource.find(1)
    end
    
    it "should read from the cache" do
      CachedResource.find(1).should == @thing
    end
    
    it "should delete from the cache when an object is DELETEd" do
      CachedResource.connection.should_receive(:delete_without_cache)
      CachedResource.delete(1)
      CachedResource.connection.cache_store.read(@key).should == nil
    end

    it "should delete from the cache when an object is modified" do
      thing = CachedResource.find(1)
      thing.stub(:load_attributes_from_response).and_return(@thing.attributes)
      CachedResource.connection.should_receive(:put_without_cache)
      thing.save
      CachedResource.connection.cache_store.read(@key).should == nil
    end
  end
  
  context "when a cached response is NOT available" do
    before(:each) do
      CachedResource.connection.cache_store.delete(@key)
    end
    
    it "SHOULD perform an ActiveResource request" do
      CachedResource.connection.should_receive(:get_without_cache).and_return(@thing.attributes)
      CachedResource.find(1)
    end
    
    it "should cache the response using the caching key" do
      CachedResource.connection.should_receive(:get_without_cache).and_return(@thing.attributes)
      CachedResource.find(1)
      CachedResource.connection.cache_store.read(@key).should == @thing.attributes
    end
  end
end