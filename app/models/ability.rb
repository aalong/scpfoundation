class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, User
    can :read, Room, access: 'public'

    if user

      if user.member?
      end

      if user.established?
      end

      if user.trusted?
      end

      if user.moderator?
      end
      
      if user.admin?
        can :manage, :all
      end
    end
  end
end
