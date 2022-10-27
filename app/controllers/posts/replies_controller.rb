module Posts
  class RepliesController < ApplicationController
    def index
      post = Post.find(params[:post_id])
      @replies = post.children.preload(:user).default_order
    end
  end
end
