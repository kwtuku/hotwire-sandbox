module Posts
  class AncestorsController < ApplicationController
    before_action :set_post

    def index
      @ancestors = @post.ancestors
    end

    private

    def set_post
      @post = Post.find(params[:post_id])
    end
  end
end
