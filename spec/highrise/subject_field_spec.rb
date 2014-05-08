require 'spec_helper'

describe Highrise::SubjectField do
  it { should be_a_kind_of Highrise::Base }
  let(:two_subject_fields){ [
    Highrise::SubjectField.new({:id => 1, :label => "Cabbage"}),
    Highrise::SubjectField.new({:id => 2, :label => "Chicken"})]
  }
  let(:four_subject_fields){ [
    two_subject_fields,
    Highrise::SubjectField.new({:id => 3, :label => "Pasta"}),
    Highrise::SubjectField.new({:id => 4, :label => "Beans"})].flatten
  }
  let(:subject_field_request){ ActiveResource::Request.new(:get, '/subject_fields.xml', nil, {"Authorization"=>"Bearer OAUTH_TOKEN", "Accept"=>"application/xml"}) }
  let(:two_subject_fields_request_pair){ {subject_field_request => ActiveResource::Response.new(two_subject_fields.to_xml, 200, {})} }
  let(:four_subject_fields_request_pair){ { subject_field_request => ActiveResource::Response.new(four_subject_fields.to_xml, 200, {})} }

  context 'cache disabled (default)' do
    it "does not use cache for queries" do
      ActiveResource::HttpMock.respond_to(two_subject_fields_request_pair)
      Highrise::SubjectField.find(:all)
      ActiveResource::HttpMock.respond_to(four_subject_fields_request_pair)
      Highrise::SubjectField.find(:all).size.should== 4
    end
  end

  context 'cache enabled (opt-in)' do
    before(:each) do
      Highrise::SubjectField.use_cache(true)
    end
    it "caches 'find all' to prevent too much queries for the SubjectFields" do
      ActiveResource::HttpMock.respond_to(two_subject_fields_request_pair)
      Highrise::SubjectField.find(:all)
      ActiveResource::HttpMock.reset!
      Highrise::SubjectField.find(:all).size.should== 2
    end
    it "invalidates cache" do
      ActiveResource::HttpMock.respond_to(two_subject_fields_request_pair)
      Highrise::SubjectField.find(:all)
      Highrise::SubjectField.invalidate_cache
      ActiveResource::HttpMock.respond_to(four_subject_fields_request_pair)
      Highrise::SubjectField.find(:all).size.should== 4
    end
  end

end
