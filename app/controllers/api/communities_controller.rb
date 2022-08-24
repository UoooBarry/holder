module Api
  class CommunitiesController < ApplicationController
    require_auth! except: %i[index show]
    before_action :set_community, only: %i[show subscribe]

    def index
      page = params[:page] || 1
      per_page = params[:per_page] || 10

      @communities = Community.all.default_order.page(page).per(per_page)
      @total_count = @communities.total_count

      @communities_json = @communities.as_json(include: [creator: { only: %i[id username] }])
      render_response(communities: @communities_json, total_count: @total_count)
    end

    def create
      @community = current_user.created_communities.new(community_params)
      @community.save!

      @community_json = @community.as_json(include: [creator: { only: %i[id username] }])

      render_response(sucess: true, community: @community_json)
    end

    def show
      subscribed_at = current_user&.subscribed_at?(@community) if current_user&.subscribe?(@community)

      render_response(community: @community, subscribed_at: subscribed_at)
    end

    def subscribe
      current_user.subscribe!(@community)

      render_response(success: true)
    end

    private

    def community_params
      params.permit(:name, :description)
    end

    def set_community
      @community = Community.find(params[:id])
    end
  end
end
