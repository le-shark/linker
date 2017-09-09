class Comment < ApplicationRecord
  acts_as_votable
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  has_many :savings, class_name: 'Saving',
                        foreign_key: 'saved_comment_id'
  has_many :savers, through: :savings

  def upvote(user)
    self.upvote_by user
    self.user.increase_comment_karma
  end

  def downvote(user)
    self.downvote_by user
    self.user.decrease_comment_karma
  end

  def score
    self.get_upvotes.size - self.get_downvotes.size
  end
end
