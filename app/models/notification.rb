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

  def path
    case notification_type
    when 'system'
      nil
    when 'mention'
      case target_type
      when 'message'
        "/rooms/#{target_place}/messages/#{target_id}"
      else
        nil
      end
    else
      nil
    end
  end

  private

  def publish
    NotificationsCounterPusher.new(user).add_content.push
  end
end
