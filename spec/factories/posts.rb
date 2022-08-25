# == Schema Information
#
# Table name: posts
#
#  id           :bigint           not null, primary key
#  user_id      :bigint           not null
#  community_id :bigint           not null
#  post_id      :bigint
#  title        :string           not null
#  content      :text             not null
#  status       :integer          default("draft"), not null
#  pin          :boolean          default(FALSE), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
FactoryBot.define do
  factory :post do
    association :user
    association :community
    title { 'MyString' }
    content { 'MyText' }
  end
end
