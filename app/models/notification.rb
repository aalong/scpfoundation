class Notification < ActiveRecord::Base
  belongs_to :user
  after_create :publish

  NOTIFICATION_TYPES = [:mention, :system]
  TARGET_TYPES = [:message]

  validates :user, presence: true
  validates :notification_type, inclusion: { in: NOTIFICATION_TYPES }
  validates :target_type, inclusion: { in: TARGET_TYPES }, allow_blank: true

  def originator
    @originator ||= User.find(originator_id)
  end

  private

  def publish
    NotificationsPusher.new(user).add_content(self).push
  end
end
