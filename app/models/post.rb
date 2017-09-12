class Post < ApplicationRecord
  belongs_to :user
  belongs_to :community
  validates :type, presence: true
  validates :title, presence: true
  acts_as_votable
  has_many :comments, as: :commentable

  has_many :savings, class_name: 'Saving',
                        foreign_key: 'saved_post_id'
  has_many :savers, through: :savings

  self.per_page = 10

  def bump_community
    self.community.bump
  end

  def comments_count
    count = 0
    self.comments.each do |c|
      count += self.comment_comments_count c
    end
    count
  end

  def comment_comments_count(comment)
    count = 1
    if comment.comments.count != 0
      comment.comments.each do |c|
        count += self.comment_comments_count c
      end
    end
    count
  end

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

  def gild
    self.gold = self.gold + 1
    self.save
  end

  def image?
    self.link.end_with?(".jpg", ".jpeg", ".png", ".gif")
  end

  def video?
    video = /^((?:https?:)?\/\/)?((?:www|m)\.)?((?:youtube\.com|youtu.be))(\/(?:[\w\-]+\?v=|embed\/|v\/)?)([\w\-]+)(\S+)?$/
    !!self.link.match(video)
  end

  def vid_id
    id = /(?:.be\/|\/watch\?v=|\/(?=p\/))([\w\/\-]+)/
    self.link.match(id)[1]
  end

  def link?
    self.type == "Link"
  end
end
