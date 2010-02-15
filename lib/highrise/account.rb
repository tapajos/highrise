module Highrise
  class Account < Base
    def self.me
      user = Account.new()
      find(:one, :from => "/account.xml")
    end
  end
end