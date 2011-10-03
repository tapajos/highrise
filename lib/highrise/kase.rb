module Highrise
  class Kase < Subject
    include Pagination

    def open!
      update_attribute(:closed_at, nil)
    end

    def close!
      update_attribute(:closed_at, Time.now.utc)
    end

    def self.open
      Kase.find(:all, :from => "/kases/open.xml")
    end

    def self.closed
      Kase.find(:all, :from => "/kases/closed.xml")
    end

    def self.all_open_across_pages
      find_all_across_pages(:from => "/kases/open.xml")
    end

    def self.all_closed_across_pages
      find_all_across_pages(:from => "/kases/closed.xml")
    end
  end
end
