module Highrise
  class User < Base
    def join(group)
      Membership.create(:user_id => id, :group_id => group.id)
    end
  end
end