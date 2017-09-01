class Post < ApplicationRecord
  belongs_to :user
  belongs_to :community
  validates :type, presence: true
  validates :title, presence: true

  def image?
    self.link.end_with?(".jpg", ".jpeg", ".png")
  end

  def link?
    self.type == "Link"
  end
end
