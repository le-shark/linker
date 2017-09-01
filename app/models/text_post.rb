class TextPost < Post
  validates :text, presence: true
  def self.model_name
    Post.model_name
  end
end
