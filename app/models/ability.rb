class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, User

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
      end
    end
  end
end
