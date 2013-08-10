class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :token_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  HSTORE_PROPERTIES = [ :real_name, :about, :birthday, :gender, :timezone, :locale ]
  PROPERTIES        = [:password, :password_confirmation, :current_password] + HSTORE_PROPERTIES

  include Roleable

  attr_accessor :login
  store_accessor :properties, HSTORE_PROPERTIES

  before_save :reset_authentication_token
  before_validation :prepare_username
  after_initialize :load_defaults

  validates :username, uniqueness: { case_sensitive: false }, format: /\A[\w\_\-\d]+\Z/,  length: { within: 3..30 }
  validates :locale, inclusion: { in: %w(ru en) }, allow_blank: true
  validates :timezone, inclusion: { in: ActiveSupport::TimeZone.zones_map(&:name) }, allow_blank: true
  validates :birthday, format: { with: /\A\d\d\d\d-\d\d-\d\d\z/ }, allow_blank: true

  def to_param
    username
  end

  def birthdate
    unless self.birthday.blank?
      Date.strptime self.birthday, "%Y-%m-%d"
    end
  end

  def age
    now = Time.now.utc.to_date
    dob = self.birthdate
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  private

  def validate_password?
    password.present? || password_confirmation.present?
  end

  def prepare_username
    write_attribute :display_name, read_attribute(:username)
      .strip
      .gsub(/\s+/i, ' ')
    write_attribute :username, read_attribute(:username)
      .strip
      .downcase
      .gsub(' ', '-')
      .gsub(/\-+/i, '-')
  end

  def load_defaults
    self.timezone = SCPX::Application::TIMEZONE if self.timezone.blank?
    self.locale   = SCPX::Application::LOCALE   if self.locale.blank?
    self.gender   = 'male'                      if self.gender.blank?
  end
end
