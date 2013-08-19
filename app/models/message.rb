class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :room

  validates :message_type, inclusion: { in: %w(message action topic) }
end
