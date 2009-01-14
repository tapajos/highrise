module Highrise
  class Kase < Subject
    def close!
      self.closed_at = Time.now.utc
      save
    end
  end
end