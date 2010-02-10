module Highrise
  class Subject < Base
    def notes
      Note.find_all_across_pages(:from => "/#{self.class.collection_name}/#{id}/notes.xml")
    end

    def add_note(attrs={})
      attrs[:subject_id] = self.id
      attrs[:subject_type] = self.label
      Note.create attrs
    end

    def emails
      Email.find_all_across_pages(:from => "/#{self.class.collection_name}/#{id}/emails.xml")
    end

    def upcoming_tasks
      Task.find(:all, :from => "/#{self.class.collection_name}/#{id}/tasks.xml")
    end
    
    def label
      self.class.to_s.split('::').last
    end
  end
end