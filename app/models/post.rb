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
class Post < ApplicationRecord
  belongs_to :user
  belongs_to :community
  belongs_to :post, optional: true

  validates :title, :content, :user_id, :community_id, presence: true

  scope :default_order, -> { order('created_at DESC') }

  default_scope { main_posts.published }

  scope :by_user, ->(user_id) { where(user_id: user_id) }
  scope :by_community, ->(community_id) { where(community_id: community_id) }
  scope :main_posts, -> { where(post_id: nil) }

  enum status: { draft: 0, published: 1, deleted: 2 }

  def comments
    Post.where(post_id: id)
  end
end
