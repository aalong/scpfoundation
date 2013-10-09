require 'action_pusher'

class NotificationsCounterPusher < ActionPusher
  def initialize(user)
    @user = user
  end

  def channel
    "/users/#{@user.id}/notifications/new"
  end

  def add_content
    @counter = @user.unread_notifications
    Pushable.new channel, render(template: 'notifications/update_counter')
  end
end
