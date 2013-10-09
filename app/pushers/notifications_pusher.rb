require 'action_pusher'

class NotificationsPusher < ActionPusher
  def initialize(user)
    @user = user
  end

  def channel
    "/users/#{@user.id}/notifications/new"
  end

  def add_content content
    @notification = content
    Pushable.new channel, render(template: 'notifications/add_notice')
  end
end
