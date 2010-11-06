module Highrise
  class Party < Base
    def self.recently_viewed
      find(:all, :from => "/parties/recently_viewed.xml")
    end
    
    def self.deletions_since(time)
      find(:all, :from => "/parties/deletions.xml", :params => { :since => time.utc.strftime("%Y%m%d%H%M%S") })
    end
  end
end