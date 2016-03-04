module Highrise
  class Person < Subject
    include Pagination
    include Taggable
    include Searchable
    include CustomFields

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

    def phone_numbers
      contact_data.phone_numbers.collect { |phone_number| phone_number.number } rescue []
    end

    def label
      'Party'
    end
  end
end
