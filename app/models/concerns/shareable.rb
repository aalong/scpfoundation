require 'active_support/concern'
module Shareable
  extend  ActiveSupport::Concern

  LEVELS = %w(private community public)

  included do
    attr_accessor :author_ids
    validates :access, inclusion: { in: LEVELS }
    has_many :sharings, as: :shareable
    has_many :users, through: :sharings, as: :shareable
  end
end
