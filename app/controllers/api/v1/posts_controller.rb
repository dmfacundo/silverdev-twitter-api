class Api::V1::PostsController < ApplicationController
  # POST /posts
  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # GET /feed
  def feed
    render json: current_user.feed(params[:page] || 1)
  rescue ArgumentError => e
    render json: { error: e.message }, status: :bad_request
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
