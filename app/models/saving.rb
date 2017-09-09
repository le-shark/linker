class Saving < ApplicationRecord
  belongs_to :saver, class_name: 'User'
  belongs_to :saved_post, class_name: 'Post', optional: true
  belongs_to :saved_comment, class_name: 'Comment', optional: true
end
