class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, User
    can :read, Room, access: 'public'
    
    if user
      can [:read, :use], Room, ["id IN (SELECT shareable_id FROM sharings WHERE user_id = ?)", user.id] do |page|
        page.users.include? user
      end

      if user.member?
        can :use, Room, access: 'public'
        can [:read, :use], Room, access: 'community'
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
