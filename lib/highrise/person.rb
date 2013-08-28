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
  end
end
