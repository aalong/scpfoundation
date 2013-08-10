require 'active_support/concern' 
module Roleable
  extend ActiveSupport::Concern

  ROLES = {
    registered_user: 1,
    member: 500,
    established_member: 2000,
    trusted_member: 5000,
    moderator: 15000,
    admin: 30000
  }

  included do
    scope :members,     -> { where("reputation >= #{ROLES[:member]}") }
    scope :established, -> { where("reputation >= #{ROLES[:established_member]}") }
    scope :trusted,     -> { where("reputation >= #{ROLES[:trusted_member]}") }
    scope :moderators,  -> { where("reputation >= #{ROLES[:moderator]}") }
    scope :admins,      -> { where("reputation >= #{ROLES[:admin]}") }
    scope :staff,       -> { where("reputation >= #{ROLES[:moderator]}") }
    scope :regular,     -> { where("reputation <  #{ROLES[:moderator]}") }
  end

  def role
    case reputation
    when ROLES[:member]...ROLES[:established_member]
      :member
    when ROLES[:established_member]...ROLES[:trusted_member]
      :trusted_member
    when ROLES[:trusted_member]...ROLES[:moderator]
      :trusted_member
    when ROLES[:moderator]...ROLES[:admin]
      :moderator
    when ROLES[:admin]...100000
      :admin
    else
      :registered_user
    end
  end

  def role= role
    set_reputation_by_role(role)
  end

  def set_role role
    set_reputation_by_role(role) && save!
  end

  def member?
    reputation >= ROLES[:member]
  end

  def established?
    reputation >= ROLES[:established_member]
  end

  def trusted?
    reputation >= ROLES[:trusted_member]
  end

  def moderator?
    reputation >= ROLES[:moderator]
  end

  def admin?
    reputation >= ROLES[:admin]
  end

  def staff?
    moderator? || admin?
  end

  def regular?
    !(moderator? || admin?)
  end

  private

  def set_reputation_by_role role
    if ROLES.has_key? role
      write_attribute(:reputation, ROLES[role])
    else
      false
    end
  end
end
