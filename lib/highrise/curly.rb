require 'hpricot'
require 'iconv'
require 'curb'
require 'uri'

class Curly < ActiveSupport::BasicObject
  attr_reader :uri
  
  def initialize(uri = nil)
    @curl = Curl::Easy.new
    self.uri = uri
    self.follow_location = true
    yield self if block_given?
  end
  
  def uri=(obj)
    case obj
    when String
      unless @uri
        @uri = URI.parse(obj)
      else
        @uri += obj
      end
    when URI::HTTP
      @uri = obj
    when nil
      return
    else
      raise "unsupported URI type (#{obj.class.name} given)"
    end
    
    self.url = @uri.to_s
  end
  
  def method_missing(method, *args, &block)
    @curl.send(method, *args, &block)
  end
  
  def cookiejar=(filename)
    self.enable_cookies = true
    @curl.cookiejar = filename
  end
  
  def get(uri = nil)
    self.uri = uri
    http_get
    raise "expected 2xx, got #{response_code} (GET #{url})" unless success?
    self
  end
  
  def success?
    response_code >= 200 and response_code < 300
  end
  
  def doc
    Hpricot body_unicode
  end
  
  def encoding
    return @encoding unless @encoding == false
    @encoding = if body_str =~ /;\s*charset=([\w-]+)\s*['"]/
      $1.downcase
    else
      false
    end
  end
  
  def post(params)
    fields = params.map do |key, value|
      Curl::PostField.content(key.to_s, value.to_s)
    end
    http_post *fields
  end
  
  class Form
    def initialize(element)
      @node = element
    end
    
    def elements
      @node.search('input, button, select, textarea')
    end
  end
  
  protected
  
    def body_unicode
      body = body_str
      if encoding and encoding != 'utf-8'
        body = Iconv.conv('UTF-8', encoding, body)
      end
      body
    end
    
end

Hpricot::Doc.class_eval do
  def forms
    search('form').map { |f| Curly::Form.new(f) }
  end
end
