class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  attr_accessor :password, :password_confirmation
  before_save{ |user| user.email = email.downcase }
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
end
