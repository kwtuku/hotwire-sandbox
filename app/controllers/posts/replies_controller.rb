module Posts
  class RepliesController < ApplicationController
    def index
      post = Post.find(params[:post_id])
      @replies = post.children.default_order
    end
  end
end
