module Posts
  class RepliesController < ApplicationController
    before_action :set_post

    def index
      @replies = @post.children.default_order
    end

    def new
      @reply = @post.children.new
    end

    def create
      @reply = @post.children.new(reply_params)
      if @reply.save
        flash.now.notice = t('posts.replied')
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def set_post
      @post = Post.find(params[:post_id])
    end

    def reply_params
      params.require(:reply).permit(:content)
    end
  end
end
