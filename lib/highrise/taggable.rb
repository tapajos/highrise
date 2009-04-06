module Highrise
  module Taggable
    def tag!(tag_name)
      # thanks for the user Inka, http://forum.37signals.com/highrise/forums/15/topics/1312?page=2
      self.post(:tags, :name => tag_name) unless tag_name.blank?
      true
    end
  end
end
