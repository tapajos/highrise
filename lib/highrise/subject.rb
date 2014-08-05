module Highrise
  class Subject < Base
    def notes(options={})
      options.merge!(:from => "/#{self.class.collection_name}/#{id}/notes.xml")
      Note.find_all_across_pages(options)
    end

    def add_note(attrs={})
      attrs[:subject_id] = self.id
      attrs[:subject_type] = self.label
      Note.create attrs
    end
    
    def add_task(attrs={})
      attrs[:subject_id] = self.id
      attrs[:subject_type] = self.label
      Task.create attrs
    end

    def emails(options={})
      options.merge!(:from => "/#{self.class.collection_name}/#{id}/emails.xml")
      Email.find_all_across_pages(options)
    end

    def upcoming_tasks(options={})
      options.merge!(:from => "/#{self.class.collection_name}/#{id}/tasks.xml")
      Task.find(:all, options)
    end
    
    def label
      self.class.name.split('::').last
    end
  end
end