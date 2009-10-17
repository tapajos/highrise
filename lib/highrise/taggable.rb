module Highrise
  module Taggable        
    def tags
      self.get(:tags)
    end
    def tag!(tag_name)
      self.post(:tags, :name => tag_name) unless tag_name.blank?
    end    
    def untag!(tag_name)
      to_delete = self.tags.find{|tag| tag['name'] == tag_name} unless tag_name.blank?
      self.untag_id!(to_delete['id']) unless to_delete.nil?
    end     
    def untag_id!(tag_id)
      self.delete("tags/#{tag_id}")
    end
  end
end
