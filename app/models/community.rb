# == Schema Information
#
# Table name: communities
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Community < ApplicationRecord
  validates :name, presence: true

  has_many :communities_users, class_name: 'CommunitiesUser', dependent: :destroy
  has_many :users, through: 'communities_users'
end
