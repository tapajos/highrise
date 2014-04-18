module Highrise
  class Person < Subject
    include Pagination
    include Taggable
    include Searchable

    def tags
      self.attributes.has_key?("tags") ? self.attributes["tags"] : super
    end

    def company
      Company.find(company_id) if company_id
    end

    def name
      "#{first_name rescue ''} #{last_name rescue ''}".strip
    end

    def address
      contact_data.addresses.first
    end

    def web_address
      contact_data.web_addresses.first
    end

    def label
      'Party'
    end
    
    def field(field_label)
      custom_fields = attributes["subject_datas"] ||= []
      field = custom_fields.detect { |field|
        field.subject_field_label == field_label
      }
      field ? field.value : nil
    end
    
    def new_subject_data(field, value)
      Highrise::SubjectData.new(:subject_field_id => field.id, :subject_field_label => field.label, :value => value)
    end
    
    def set_field_value(field_label, new_value)
      custom_fields = attributes["subject_datas"] ||= []
      custom_fields.each { |field|
        return field.value = new_value if field.subject_field_label== field_label
      }
  
      SubjectField.find(:all).each { |custom_field| 
        if custom_field.label == field_label
          return attributes["subject_datas"] << new_subject_data(custom_field, new_value)
        end
      }
    end
        
  end
end
