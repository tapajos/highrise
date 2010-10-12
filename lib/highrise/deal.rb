module Highrise
  class Deal < Subject
    def update_status(status)
      raise ArgumentError, "status must be won of 'pending', 'won', or 'lost'" unless ["pending", "won", "lost"].include?(status)
      self.put(:status, :status => {:name => status})
    end
  end
end