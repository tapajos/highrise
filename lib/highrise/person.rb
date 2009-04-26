module Highrise
  class Person < Subject
    include Pagination
    include Taggable
    
    def self.find_all_across_pages_since(time)
      find_all_across_pages(:params => { :since => time.utc.to_s(:db).gsub(/[^\d]/, '') })
    end
  
    def company
      Company.find(company_id) if company_id
    end
  
    def name
      "#{first_name rescue ''} #{last_name rescue ''}".strip
    end
    
  end

end