class User < ApplicationRecord
  before_save { self.email = self.email.downcase }
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  NAME_REGEX = /^[a-zA-Z0-9\-\_]*$/i
  validates :username, presence: true, uniqueness: { case_sensitive: false },
                       length: { maximum: 50 }
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    length: { maximum: 255 }, format: { with: EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 6 }
  validates :about_me, length: { maximum: 500 }
  has_secure_password

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
