require File.dirname(__FILE__) + '/../spec_helper'

describe Highrise::CurlHelper do
  before do
    @curl_helper = Highrise::CurlHelper.new
  end
  
  it "should return token and username from Highrise url" do
    highrise_url = "http://00000000000000000aaaaaaabbbbbbbbbbbvvccc:username@planobe.highrisehq.com/"
    @curl_helper.get_userpwd_from_url(highrise_url).should == "00000000000000000aaaaaaabbbbbbbbbbbvvccc:username"
  end
  
  it "should return a company html document from Highrise" do
    url = "companies/16883216"
    file_path = File.dirname(__FILE__) + "/#{url}.html"
    @curl_helper.stub!(:get_document).and_return(Hpricot(File.open(file_path,"r"){|f| f.read}))    
    
    doc = @curl_helper.get_document_from_id(url)
    doc.class.should == Hpricot::Doc
    company_rss_link = doc.search("#stream a").first
    company_rss_link['href'].should == "http://planobe.highrisehq.com/#{url}.atom" 
  end   
  
  it "should return a person html document from Highrise" do
    url = "people/16887003"
    file_path = File.dirname(__FILE__) + "/#{url}.html"
    @curl_helper.stub!(:get_document).and_return(Hpricot(File.open(file_path,"r"){|f| f.read}))    
    
    doc = @curl_helper.get_document_from_id(url)
    doc.class.should == Hpricot::Doc
    company_rss_link = doc.search("#stream a").first
    company_rss_link['href'].should == "http://planobe.highrisehq.com/#{url}.atom" 
  end
  
end