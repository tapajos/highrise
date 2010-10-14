module Highrise
  class Kase < Subject
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
  end
end