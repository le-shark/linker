class Community < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:finders, :slugged]
  has_many :moderations, class_name: 'Moderation',
                        foreign_key: 'moderated_id'
  has_many :moderators, through: :moderations
  NAME_REGEX = /\A[a-zA-Z0-9\-\_]*$\z/i
  validates :name, presence: true, uniqueness: { case_sensitive: false },
                       length: { maximum: 50 }, format: { with: NAME_REGEX }
end
