# == Schema Information
#
# Table name: communities
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  creator_id  :bigint
#
class Community < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :communities_users, class_name: 'CommunitiesUser', dependent: :destroy
  has_many :users, through: 'communities_users'
  # allow no creator community created by system
  belongs_to :creator, class_name: 'User', optional: true

  scope :default_order, -> { order('created_at DESC') }
end
