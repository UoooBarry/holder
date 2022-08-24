# == Schema Information
#
# Table name: communities_users
#
#  id           :bigint           not null, primary key
#  user_id      :bigint
#  community_id :bigint
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class CommunitiesUser < ApplicationRecord
  belongs_to :user
  belongs_to :community
  validates :user_id, uniqueness: { scope: :community, message: 'already subscribed to this community.' }
end
