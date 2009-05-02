require File.dirname(__FILE__) + '/../spec_helper'

describe Curly do
  before do
    @curly = Curly.new
  end
  
  it "should enable cookies when cookiejar is set" do
    @curly.enable_cookies?.should == false
    @curly.cookiejar = 'foo'
    @curly.enable_cookies?.should == true
  end
  
  it "should post params hash" do
    field_arg = an_instance_of(Curl::PostField)
    @curly.should_receive(:http_post).with(field_arg, field_arg)
    @curly.post(:foo => 'bar', :baz => 'foo')
  end
  
  it "should get document" do
    @curly.should_receive(:http_get).with().and_return(true)
    @curly.stub!(:response_code).and_return(200)
    @curly.stub!(:body_str).and_return(<<-HTML)
      <html>
        <body>You are being
          <a href=\"http://localhost:3000/login\">redirected</a>.
        </body>
      </html>
    HTML
    
    doc = @curly.get('http://example.com').doc
    @curly.url.should == 'http://example.com'
    doc.class.should == Hpricot::Doc
    doc.at('a[@href]').inner_text.should == 'redirected'
  end
end
