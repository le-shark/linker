class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  has_many :savings, class_name: 'Saving',
                        foreign_key: 'saved_comment_id'
  has_many :savers, through: :savings
end
