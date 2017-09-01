class User < ApplicationRecord
  extend FriendlyId
  friendly_id :username, use: [:finders, :slugged]
  attr_accessor :remember_token
  attr_readonly :username
  before_save { self.email = self.email.downcase }
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  NAME_REGEX = /\A[a-zA-Z0-9\-\_]*$\z/i
  validates :username, presence: true, uniqueness: { case_sensitive: false },
                       length: { maximum: 50 }, format: { with: NAME_REGEX }
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    length: { maximum: 255 }, format: { with: EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :about_me, length: { maximum: 500 }
  has_secure_password
  has_many :moderations, class_name: 'Moderation',
                                   foreign_key: 'moderator_id'
  has_many :moderated_communities, through: :moderations, source: :moderated
  has_many :posts

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def authenticated?
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end
end
