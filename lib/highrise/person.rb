module Highrise
  class Person < Subject
    include Pagination
    include Taggable
    include Searchable

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

    def email_addresses
      contact_data.email_addresses.collect { |address| address.address } rescue []
    end

    def label
      'Party'
    end

    def field(field_label)
      custom_fields = attributes["subject_datas"] ||= []
      field = custom_fields.detect do |field|
        field.subject_field_label == field_label
      end
      field ? field.value : nil
    end

    def new_subject_data(field, value)
      Highrise::SubjectData.new(:subject_field_id => field.id, :subject_field_label => field.label, :value => value)
    end

    def set_field_value(field_label, new_value)
      custom_fields = attributes["subject_datas"] ||= []
      custom_fields.each do |field|
        return field.value = new_value if field.subject_field_label == field_label
      end

      SubjectField.find(:all).each do |custom_field|
        if custom_field.label == field_label
          return attributes["subject_datas"] << new_subject_data(custom_field, new_value)
        end
      end
    end

    def transform_subject_field_label field_label
      field_label.downcase.tr(' ', '_')
    end

    def convert_method_to_field_label method
      custom_fields = attributes["subject_datas"] ||= []
      custom_fields.each do |field|
        method_name_from_field = transform_subject_field_label(field.subject_field_label)
        return field if method_name_from_field == method
      end
      nil
    end

    def method_missing(method_symbol, *args)
      method_name = method_symbol.to_s

      if method_name[-1,1] == "="
        attribute_name = method_name[0...-1]
        field = convert_method_to_field_label(attribute_name)
        return set_field_value(field.subject_field_label, args[0]) if field

        return super if attributes[attribute_name]

        subject_fields = SubjectField.find(:all)
        unless subject_fields.nil?
          subject_fields.each do |custom_field|
            if transform_subject_field_label(custom_field.label) == attribute_name
              return attributes["subject_datas"] << new_subject_data(custom_field, args[0])
            end
          end
        end
      else
        field = convert_method_to_field_label(method_name)
        return field(field.subject_field_label) if field
      end
      super
     end
  end
end
