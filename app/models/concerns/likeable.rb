# 点赞功能
module Likeable
  extend ActiveSupport::Concern

  def liked_by?(user)
    liked_users.include?(user)
  end

  # @param [User] user
  # @return [Boolean] true if user liked the post, false otherwise
  def liked_by(user)
    return unless respond_to?(:likes)

    like = likes.find_or_initialize_by(user: user)

    new_like = like.new_record?

    new_like ? like.save : like.destroy

    new_like.present?
  end

  def likes_count
    likes.size
  end
end
