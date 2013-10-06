require 'active_support/concern'
module Shareable
  extend  ActiveSupport::Concern

  LEVELS = %w(private community public)

  included do
    attr_accessor :author_ids
    validates :access, inclusion: { in: LEVELS }
    has_many :sharings, as: :shareable
    has_many :users, through: :sharings, as: :shareable
    before_validation :set_access
  end

  private

  def set_access
    if read_attribute(:access).blank? || !LEVELS.include?(read_attribute(:access))
      write_attribute :access, 'private'
    end
  end
end
