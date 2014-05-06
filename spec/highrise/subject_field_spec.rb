require 'spec_helper'

describe Highrise::SubjectField do
  it { should be_a_kind_of Highrise::Base }
  
  before (:each) do
    two_subject_fields = [
                        Highrise::SubjectField.new({:id => 1, :label => "Cabbage"}), 
                        Highrise::SubjectField.new({:id => 2, :label => "Chicken"})]
    four_subject_fields = [ two_subject_fields, 
                        Highrise::SubjectField.new({:id => 3, :label => "Pasta"}), 
                        Highrise::SubjectField.new({:id => 4, :label => "Beans"})].flatten
    subject_field_request = ActiveResource::Request.new(:get, '/subject_fields.xml', nil, {"Authorization"=>"Bearer OAUTH_TOKEN", "Accept"=>"application/xml"})
    two_subject_field_response = ActiveResource::Response.new(two_subject_fields.to_xml, 200, {})
    four_subject_field_response = ActiveResource::Response.new(four_subject_fields.to_xml, 200, {})
    @two_subject_fields_request_pair = { subject_field_request => two_subject_field_response}
    @four_subject_fields_request_pair = { subject_field_request => four_subject_field_response}
    
    Highrise::SubjectField.use_cache(false)
  end
  
  it "Should by default not use the cache for queries" do
    ActiveResource::HttpMock.respond_to(@two_subject_fields_request_pair)
    Highrise::SubjectField.find(:all)
    ActiveResource::HttpMock.respond_to(@four_subject_fields_request_pair)
    Highrise::SubjectField.find(:all).size.should== 4
  end
  
  it "When cache turned on, it should cache the find all to prevent too much queries for the SubjectFields" do
    Highrise::SubjectField.use_cache
    ActiveResource::HttpMock.respond_to(@two_subject_fields_request_pair)        
    Highrise::SubjectField.find(:all)
    ActiveResource::HttpMock.reset!
    Highrise::SubjectField.find(:all).size.should== 2
  end
  
  it "Should be able to invalidate the cache" do
    Highrise::SubjectField.use_cache
    ActiveResource::HttpMock.respond_to(@two_subject_fields_request_pair)        
    Highrise::SubjectField.find(:all)
    Highrise::SubjectField.invalidate_cache
    ActiveResource::HttpMock.respond_to(@four_subject_fields_request_pair)
    Highrise::SubjectField.find(:all).size.should== 4
  end
end