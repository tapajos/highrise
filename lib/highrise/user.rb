module Highrise
  class User < Base
    def join(group)
      Membership.create(:user_id => id, :group_id => group.id)
    end

    # Permits API-key retrieval using name and password.
    #     Highrise::User.site = "https://yourcompany.highrise.com"
    #     Highrise::User.user = "your_user_name"
    #     Highrise::User.password = "s3kr3t"
    #     Highrise::User.me.token # contains the API token for "your_user_name"  
    def self.me
      user = User.new()
      find(:one, :from => "/me.xml")
    end
  end
end