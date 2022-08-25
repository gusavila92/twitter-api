class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    render(json: { errors: @post.errors }, status: :bad_request) unless @post.save
  end

  private

  def post_params
    params.permit(:body)
  end
end
