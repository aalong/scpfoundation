class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications.sort_by(&:created_at).reverse
  end

  def show
    notification = current_user.notifications.find params[:id]
    notification.update_attribute :read, true
    redirect_to "http://#{request.host}:#{request.port}#{notification.path}"
    NotificationsCounterPusher.new(current_user).add_content.push
  end

  def read
    notification = current_user.notifications.find params[:id]
    respond_to do |format|
      if notification.update_attribute(:read, true)
        NotificationsCounterPusher.new(current_user).add_content.push
        format.html { redirect_to notifications_path, notice: 'Notification was successfully updated' }
        # format.js
      else
        format.html { redirect_to notifications_path, alert: 'Notification was not updated' }
        # format.js { 'alert("Can not mark notification as read")'; }
      end
    end
  end

  def read_all
    notifications = current_user.notifications
    respond_to do |format|
      if notifications.update_all(read: true)
        format.html { redirect_to notifications_path, notice: 'Notifications were successfully marked as read' }
        # format.js
      else
        format.html { redirect_to notifications_path, alert: 'Notifications were not marked as read' }
        # format.js { 'alert("Can not mark notifications as read")'; }
      end
    end
  end

  def destroy_read
    notifications = current_user.notifications.where(read: true)
    respond_to do |format|
      if notifications.destroy_all
        format.html { redirect_to notifications_path, notice: 'All read notifications were deleted' }
        # format.js
      else
        format.html { redirect_to notifications_path, alert: "Can't delete read notifications :(" }
        # format.js { 'alert("Can not delete read notifications")'; }
      end
    end
  end
end
