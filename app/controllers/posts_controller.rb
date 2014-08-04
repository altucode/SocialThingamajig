class PostsController < ApplicationController
  before_action :require_current_user!

  def create
    @post = Post.new(post_params)

    if @post.save
      render :show
    else
      render json: @post.errors.full_messages
    end
  end

  def new
    @post = Post.new
    render :new
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def feed
    render :feed
  end


  private
  def post_params
    params.require(:post).permit(:user_id, :body, link_urls: [], circle_ids: [])
  end
end
