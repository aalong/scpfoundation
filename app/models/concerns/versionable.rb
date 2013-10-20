require 'active_support/concern'
module Versionable
  extend ActiveSupport::Concern

  included do
    has_many :versions, as: :versionable
    before_update :create_version
  end

  def editor
    @editor ||= editor_id.nil? ? user : User.find(editor_id)
  end

  def originator
    editor.username
  end

  def rollback version_id
    version = versions.find version_id
    restore_version version.values.merge({
      id: version.id,
      editor_id: version.user_id,
      commit_message: version.commit_message
    })
  end

  def create_version
    new_version = prepare_version
    versions.create!(new_version) if new_version
  end
end

