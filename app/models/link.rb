class Link < Post
  validates :link, presence: true
  def self.model_name
    Post.model_name
  end
end
