class PostsController < ApplicationController
  def index
    @posts = Post.roots.preload(:user).default_order.page(params[:page]).without_count
  end

  def show
    @post = Post.find(params[:id])
  end
end
