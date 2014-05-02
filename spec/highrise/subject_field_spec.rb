require 'spec_helper'

describe Highrise::SubjectField do
  it { should be_a_kind_of Highrise::Base }
    
  it "Should cache the find all to prevent too much queries for the SubjectFields" do
    
    subject_fields = [ Highrise::SubjectField.new({:id => 1, :label => "Cabbage"}), 
                        Highrise::SubjectField.new({:id => 2, :label => "Chicken"})]
    
    ActiveResource::HttpMock.respond_to do |mock|      
      mock.get    "/subject_fields.xml", {"Authorization"=>"Bearer OAUTH_TOKEN", "Accept"=>"application/xml"}, subject_fields.to_xml
    end
        
    Highrise::SubjectField.find(:all).length.should==2

    ActiveResource::HttpMock.respond_to do |mock|      
    end

    Highrise::SubjectField.find(:all).length.should==2
  end
  
  it "Should be able to invalidate the cache" do
    subject_fields = [ Highrise::SubjectField.new({:id => 1, :label => "Cabbage"}), 
                       Highrise::SubjectField.new({:id => 2, :label => "Chicken"})]
    
    ActiveResource::HttpMock.respond_to do |mock|      
      mock.get    "/subject_fields.xml", {"Authorization"=>"Bearer OAUTH_TOKEN", "Accept"=>"application/xml"}, subject_fields.to_xml
    end
        
    Highrise::SubjectField.find(:all)

    ActiveResource::HttpMock.respond_to do |mock|      
      mock.get    "/subject_fields.xml", {"Authorization"=>"Bearer OAUTH_TOKEN", "Accept"=>"application/xml"}, [].to_xml
    end
    Highrise::SubjectField.invalidate_cache
    Highrise::SubjectField.find(:all).length.should==0
  end
end