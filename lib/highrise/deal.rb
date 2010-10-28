module Highrise
  class Deal < Subject
    def update_status(status)
      raise ArgumentError, "status must be one of 'pending', 'won', or 'lost'" unless %w[pending won lost].include?(status)
      self.put(:status, :status => {:name => status})
    end
  end
end