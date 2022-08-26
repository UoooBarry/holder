module Api
  class CommunitiesController < ApplicationController
    require_auth! except: %i[index show]
    before_action :set_community, only: %i[show subscribe unsubscribe set_admin]
    before_action :validate_admin!, only: %i[set_admin]

    def index
      page = params[:page] || 1
      per_page = params[:per_page] || 10

      @communities = Community.default_order.page(page).per(per_page)
      @total_count = @communities.total_count

      @communities_json = @communities.as_json(include: [creator: { only: %i[id username] }])
      @communities_json.each do |json|
        json[:subscribed_at] = current_user&.subscribed_at?(json['id'])
      end
      render_response(communities: @communities_json, total_count: @total_count)
    end

    def create
      @community = current_user.created_communities.new(community_params)
      @community.save!

      @community_json = @community.as_json(include: [creator: { only: %i[id username] }])

      render_response(sucess: true, community: @community_json)
    end

    def show
      subscribed_at = current_user&.subscribed_at?(@community)

      render_response(community: @community, subscribed_at: subscribed_at)
    end

    def subscribe
      current_user.subscribe!(@community)

      render_response(success: current_user.subscribe?(@community))
    end

    def unsubscribe
      current_user.unsubscribe!(@community)

      render_response(success: !current_user.subscribe?(@community))
    end

    def set_admin
      @user = User.find(params[:user_id])
      @community.admin!(@user)

      render_response(success: @user.admin_of?(@community))
    end

    private

    def community_params
      params.permit(:name, :description)
    end

    def set_community
      @community = Community.find(params[:id])
    end

    def validate_admin!
      return if current_user.admin_of?(@community)

      raise UnAuthorizedResource
    end
  end
end
