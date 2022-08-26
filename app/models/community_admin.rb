# == Schema Information
#
# Table name: community_admins
#
#  id           :bigint           not null, primary key
#  community_id :bigint           not null
#  user_id      :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class CommunityAdmin < ApplicationRecord
  belongs_to :community
  belongs_to :user

  validates :user_id, uniqueness: { scope: :community, message: 'already an admin of this community.' }
end
