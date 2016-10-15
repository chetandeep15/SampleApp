class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password
  has_many :microposts, dependent: :destroy
  before_save{ |user| user.email = email.downcase }
  before_save :create_remember_token
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates_presence_of :name
  validates_length_of :name, maximum: 30

  validates_presence_of :email
  validates_format_of :email, with: VALID_EMAIL_REGEX
  validates_uniqueness_of :email

  validates_presence_of :password
  validates_confirmation_of :password
  validates_length_of :password, minimum: 6

  validates_presence_of :password_confirmation

  def feed
    Micropost.where("user_id = ?", id)
  end

  private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
