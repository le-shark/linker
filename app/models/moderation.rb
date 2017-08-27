class Moderation < ApplicationRecord
  belongs_to :moderator, class_name: 'User'
  belongs_to :moderated, class_name: 'Community'
end
