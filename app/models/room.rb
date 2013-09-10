class Room < ActiveRecord::Base
  include Shareable

  belongs_to :user
  has_many :messages
  validates :title, presence: true
end
