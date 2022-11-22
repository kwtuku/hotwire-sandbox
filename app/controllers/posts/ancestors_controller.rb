module Posts
  class AncestorsController < ApplicationController
    def index
      post = Post.find(params[:post_id])
      @ancestors = post.ancestors.preload(:user)
    end
  end
end
