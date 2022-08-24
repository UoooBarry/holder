class Post < ApplicationRecord
  belongs_to :user
  belongs_to :community
  belongs_to :post, optional: true

  validates :title, :content, presence: true

  scope :default_order, -> { order('created_at DESC') }

  scope :by_user, ->(user_id) { where(user_id: user_id) }
  scope :by_community, ->(community_id) { where(community_id: community_id) }

  def comments
    Post.where(post_id: id)
  end
end
