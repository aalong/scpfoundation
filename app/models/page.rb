class Page < ActiveRecord::Base
  include Shareable
  include Versionable

  belongs_to :namespace
  belongs_to :user

  before_validation :prepare_values
  after_validation :update_slug

  validates :name, format: /\A[\w\_\d\-]+\Z/, if: :check_name?
  validate :check_name_uniqueness
  validates :title, presence: true, length: { minimum: 2 }
  validates :content, presence: true
  validates_associated :user
  validates_associated :namespace

  def to_param
    name
  end

  def editor
    @editor ||= editor_id.nil? ? user : User.find(editor_id)
  end

  def originator
    editor.username
  end

  def prepare_values
    if read_attribute(:name).nil? || read_attribute(:name).blank?
      write_attribute :name, read_attribute(:title).parameterize
    else
      write_attribute :name, read_attribute(:name).parameterize
    end
  end

  def update_slug
    write_attribute :slug, (namespace.name.to_s + ':' + read_attribute(:name).to_s)
  end

  def check_name?
    name_changed? && !read_attribute(:name).blank?
  end

  def check_name_uniqueness
    page = Page.find_by_slug "#{namespace.name}:#{read_attribute(:name)}"
    if !page.nil? && (self.id.nil? || page.id != self.id)
      errors.add(:name, 'name is not uniq')
    end
  end

  def prepare_version
    page = Page.find id
    {
      title: page.title,
      content: page.content,
      user: page.editor,
      commit_message: page.commit_message
    }
  end

  def restore_version values
    write_attribute :title, values["title"]
    write_attribute :content, values["content"]
    write_attribute :editor_id, values["editor_id"]
    write_attribute :commit_message, "Rollback to the version #{values['id']}"
    save!
  end
end
