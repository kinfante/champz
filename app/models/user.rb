require 'digest/sha2'

class User < ActiveRecord::Base
  has_many :championships, :dependent => :destroy

  validates_presence_of :name, :login
  validates_uniqueness_of :login

  attr_accessor :password_confirmation
  validates_confirmation_of :password

  validate :password_non_blank


  def self.authenticate(login, password)
    user = self.find_by_login(login)
    if user
      expected_password = encrypted_password(password, user.salt)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end

  def password
    @password
  end

  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end

  def after_destroy
    if self.login == "kinfante"
      raise "Can't delete admin user"
    end
  end

  private

    def password_non_blank
      errors.add(:password, "Missing password") if hashed_password.blank?
    end

    def self.encrypted_password(password, salt)
      string_to_hash = password + "wibble" + salt
      Digest::SHA2.hexdigest(string_to_hash)
    end

    def create_new_salt
      self.salt = self.object_id.to_s + rand.to_s
    end
end
