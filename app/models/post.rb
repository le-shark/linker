class Post < ApplicationRecord
  belongs_to :user
  belongs_to :community
  validates :type, presence: true
  validates :title, presence: true
  acts_as_votable

  def upvote(user)
    self.upvote_by user
    self.user.increase_post_karma
  end

  def downvote(user)
    self.downvote_by user
    self.user.decrease_post_karma
  end

  def score
    self.get_upvotes.size - self.get_downvotes.size
  end

  def image?
    self.link.end_with?(".jpg", ".jpeg", ".png")
  end

  def link?
    self.type == "Link"
  end
end
