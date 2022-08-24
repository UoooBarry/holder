class Community < ApplicationRecord
  validates :name, presence: true

  has_many :communities_users, class_name: 'CommunitiesUser', dependent: :destroy
  has_many :users, through: 'communities_users'
end
