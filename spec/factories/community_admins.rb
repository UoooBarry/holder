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
FactoryBot.define do
  factory :community_admin do
    community { nil }
    user { nil }
  end
end
