module Highrise
  module Searchable
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      # List By Search Criteria
      # Ex: Highrise::Person.search(:email => "john.doe@example.com", :country => "CA")
      # Available criteria are: city, state, country, zip, phone, email
      def search(options = {})
        search_params = options.inject({}) { |h, (k, v)| h["criteria[#{k}]"] = v; h }
        # This might have to be changed in the future if other non-pagable resources become searchable
        if self.respond_to?(:find_all_across_pages)
          self.find_all_across_pages(:from => "/#{self.collection_name}/search.xml", :params => search_params)
        else
          self.find(:all, {:from => "/#{self.collection_name}/search.xml", :params => search_params})
        end
      end
    end
  end
end