class Community < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:finders, :slugged]
  has_many :moderations, class_name: 'Moderation',
                        foreign_key: 'moderated_id'
  has_many :moderators, through: :moderations
  has_many :subscriptions, class_name: 'Subscription',
                        foreign_key: 'community_id'
  has_many :subscribed_users, through: :subscriptions, source: :user
  has_many :posts
  NAME_REGEX = /\A[a-zA-Z0-9\-\_]*$\z/i
  validates :name, presence: true, uniqueness: { case_sensitive: false },
                       length: { maximum: 50 }, format: { with: NAME_REGEX }
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true
  validates :small_description, presence: true, length: { maximum: 255 }
  validates :rules, presence: true

  def subscribers
    self.subscribed_users.count
  end

  def bump
    self.bumped_at = Time.now
    self.save
  end
end
