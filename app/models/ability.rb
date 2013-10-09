class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :index, :show, :history, to: :read

    can :read, User
    can :read, Room, access: 'public'
    
    if user
      can [:read, :use], Room, ["id IN (SELECT shareable_id FROM sharings WHERE user_id = ?)", user.id] do |page|
        page.users.include? user
      end

      can [:read, :destroy], Notification, user_id: user.id

      if user.member?
        can :use, Room, access: 'public'
        can :create, Room
        can [:read, :use, :edit, :update], Room, user_id: user.id
        can [:read, :use], Room, access: 'community'
      end

      if user.established?
      end

      if user.trusted?
      end

      if user.moderator?
        can [:read, :use, :edit, :update], Room, ["id IN (SELECT shareable_id FROM sharings WHERE user_id = ?)", user.id] do |page|
          page.users.include? user
        end
      end
      
      if user.admin?
      end
    end
  end
end
