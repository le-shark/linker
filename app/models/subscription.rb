class Subscription < ApplicationRecord
  belongs_to :user, class_name: "User"
  belongs_to :community, class_name: "Community"
  validates :user_id, presence: true
  validates :community_id, presence: true
end
