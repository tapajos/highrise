module Highrise
  class SubjectField < Base
    def self.find_every(options)
      @subject_field_cache ||= super
    end
    
    def self.invalidate_cache
      @subject_field_cache = nil
    end
  end
end