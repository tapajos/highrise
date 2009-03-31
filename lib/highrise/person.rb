module Highrise
  class Person < Subject
    include Pagination
  
    def self.find_all_across_pages_since(time)
      find_all_across_pages(:params => { :since => time.to_s(:db).gsub(/[^\d]/, '') })
    end
  
    def company
      Company.find(company_id) if company_id
    end
  
    def name
      "#{first_name} #{last_name}".strip
    end
    
    def tags
      # thanks for the user Inka, http://forum.37signals.com/highrise/forums/15/topics/1312?page=2
      usertags = Array.new
      codigo = self.id
      tags = Highrise::Tag.find(:all)
      tags.each do |tag|
        id = tag.attributes["id"]
        users = Highrise::Tag.find(:all, :from => "/tags/#{id}").to_xml
        if users.scan(/#{codigo}/).size > 0
          usertags << tag.attributes["name"]
        end
      end
      usertags
    end

    def tag!(tag_name)
      # thanks for the user Inka, http://forum.37signals.com/highrise/forums/15/topics/1312?page=2
      self.post(:tags, :name => tag_name) unless tag_name.blank?
      true
    end
  
  end

end