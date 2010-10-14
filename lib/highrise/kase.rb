module Highrise
  class Kase < Subject
    def close!
      self.closed_at = Time.now.utc
      save
    end

    def self.open
      Kase.find(:all, :from => "/kases/open.xml")
    end

    def self.closed
      Kase.find(:all, :from => "/kases/closed.xml")
    end
  end
end