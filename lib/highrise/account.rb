module Highrise
  class Account < Base
    def self.me
      find(:one, :from => "/account.xml")
    end
  end
end