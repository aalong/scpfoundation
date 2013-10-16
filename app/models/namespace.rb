class Namespace < ActiveRecord::Base
  include Shareable

  belongs_to :user
  has_many :pages
  before_create :prepare_values
  after_create :create_index_page

  validates :name, format: /\A[\w\_\d\-]+\Z/, uniqueness: true
  validates :title, presence: true, length: { minimum: 2 }
  validates_associated :user

  def to_param
    name
  end

  def index_page
    @index_page ||= Page.find_by_slug "#{name}:index"
  end

  private

  def prepare_values
    write_attribute :name, read_attribute(:name).downcase
    if read_attribute(:user_id).blank?
      write_attribute :user_id, User.find_by_username('community').id
    end
  end

  def create_index_page
    pages.create!(
      user_id: read_attribute(:user_id),
      title: read_attribute(:name).capitalize,
      content: 'Default index page',
      name: 'index')
  end
end
