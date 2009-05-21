module Highrise
  module Taggable
    
    # thanks for the user Inka, http://forum.37signals.com/highrise/forums/15/topics/1312?page=2
        
    def tag!(tag_name)
      self.post(:tags, :name => tag_name) unless tag_name.blank?
    end
    
    def untag!(tag_name)
      to_delete = self.tags.find{|t| t.name==tag_name} unless tag_name.blank?
      self.untag_id!(to_delete.id) unless to_delete.nil?
    end
            
    def untag_id!(tag_id)
      self.delete("tags/#{tag_id}")
    end

    def tags      
      tags = []
      get_document.search("#show_tags a").each{ |a|
       tags << Highrise::Tag.new(:id => a['href'].gsub(/.*\//, ''), :name => a.inner_html) if a['class'] == "grey tag"
      }
      tags
    end
        
    def get_document
      @curl_helper ||= CurlHelper.new
      @doc = @curl_helper.get_document_from_id("#{self.class.collection_name}/#{self.id}")
    end
    
  end
end
