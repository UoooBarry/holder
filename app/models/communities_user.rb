class CommunitiesUser < ApplicationRecord
  belongs_to :user
  belongs_to :community
  validates :user_id, uniqueness: { scope: :community, message: 'already subscribed to this community.' }
end
