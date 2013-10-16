class Version < ActiveRecord::Base
  VERSIONABLE_PROPERTIES = [ :title, :content, :name, :namespace_id ]

  store_accessor :values, VERSIONABLE_PROPERTIES
  belongs_to :versionable, polymorphic: true
  belongs_to :user

  def user
    @user ||= User.find user_id
  end

  def originator
    user.username
  end
end
