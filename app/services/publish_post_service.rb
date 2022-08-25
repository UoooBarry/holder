class PublishPostService < ApplicationService
  class Error < StandardError; end

  def initialize(user, post_params)
    super()

    @user = user
    @post_params = post_params
  end

  def call
    Post.transaction do
      validate_user_subscribed_to_community!

      post.save!

      post.published!

      post
    rescue Error => e
      post.errors.add(:base, "Post cannot be published: #{e.message}")
      raise ActiveRecord::RecordInvalid, post
    end
  end

  private

  attr_reader :user, :post_params

  def post
    @post ||= Post.new(user: user, community: community, title: post_params[:title],
                       content: post_params[:content])
  end

  def community
    @community ||= Community.find(post_params[:community_id])
  end

  def validate_user_subscribed_to_community!
    raise Error, 'User is not subscribed to this community' unless user.subscribe?(community)
  end
end
