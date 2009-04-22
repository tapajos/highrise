module Highrise
  class CurlHelper 
    
    # thanks mislav ;) http://github.com/mislav/curly/tree/master
    
    def initialize
      @curly = Curly.new
      @curly.http_auth_types = Curl::CURLAUTH_BASIC
    end
    
    def get_userpwd_from_url(url)
      userpwd_from_url_regex = /(http|https):\/\/((?:[\w\.\-\+%!$&'\(\)*\+,;=]+:)*[\w\.\-\+%!$&'\(\)*\+,;=]+)?/
      match = userpwd_from_url_regex.match(url)
      match.captures[1] unless match.nil?
    end
    
    def get_document(url)
      @curly.userpwd = get_userpwd_from_url(url)
      @curly.get(url).doc
    end
    
    def get_document_from_id(collection_name_and_id)
      get_document("#{Highrise::Base.site.to_s}#{collection_name_and_id}")
    end
    
  end
end