module Highrise
  class Company < Subject
    include Pagination
    include Taggable
    include Searchable
    include CustomFields

    def people
      Person.find_all_across_pages(:from => "/companies/#{id}/people.xml")
    end
    
    def label
      'Party'
    end
  end
end