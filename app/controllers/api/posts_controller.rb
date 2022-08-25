module Api
  class PostsController < ApplicationController
    require_auth! except: %i[index show]
    before_action :set_post, only: %i[show update destroy like reply pin]
    before_action :validate_admin!, only: %i[pin]
    before_action :validate_post_ownership!, only: %i[update destroy]

    def index
      community_id = params[:community_id]
      user_id = params[:user_id]

      page = params[:page] || 1
      per_page = params[:per_page] || 10

      @posts = Post

      if community_id.present?
        @posts = @posts.by_community(community_id)
      elsif user_id.present?
        @posts = @posts.by_user(user_id)
      end

      @posts = @posts.default_order.page(page).per(per_page)
      @total_count = @posts.total_count

      @posts_json = @posts.as_json(include: [user: { only: %i[id username gender age] }])
      render_response(posts: @posts_json, total_count: @total_count)
    end

    def show
      @post_json = @post.as_json(include: [user: { only: %i[id username gender age] }], methods: %i[comments likes_count])

      render_response(post: @post_json)
    end

    def create
      @post = PublishPostService.call(current_user, post_params)

      render_response(success: @post.published?, post: @post)
    end

    def destroy
      @post.deleted!

      render_response(success: @post.deleted?, post: @post)
    end

    def update
      @post.update!(post_params.except(:community_id))

      render_response(success: true, post: @post)
    end

    def like
      result = @post.liked_by(current_user)
      render_response(liked: result, post: @post)
    end

    def reply
      @comment = @post.reply(current_user, params[:content])

      render_response(success: true, comment: @comment)
    end

    def pin
      pin = @post.pin!

      render_response(sucess: pin, post: @post)
    end

    private

    def post_params
      params.permit(:community_id, :title, :content)
    end

    def set_post
      @post = Post.find(params[:id])
    end

    def validate_admin!
      return if current_user.admin_of?(@post.community)

      raise UnAuthorizedResource, 'You are not authorized to access this resource'
    end

    def validate_post_ownership!
      validate_owndership!(@post)
    end
  end
end
