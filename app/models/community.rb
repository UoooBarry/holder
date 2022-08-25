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

  has_many :community_admins, class_name: 'CommunityAdmin', dependent: :destroy
  has_many :admins, through: :community_admins, source: :user

  scope :default_order, -> { order('created_at DESC') }

  after_create :creator_auto_subscribe

  def admin!(user)
    admins << user

    save!
  end

  private

  def creator_auto_subscribe
    return unless creator

    creator.subscribe!(self)
  end
end
