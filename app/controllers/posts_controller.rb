class PostsController < ApplicationController
  before_action :set_post, only: %i[ show update destroy ]

  # POST /posts
  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:body, :account_id)
  end
end
