module Users
  module Posts
    class RepliesController < Users::ApplicationController
      before_action :set_post

      def new
        @reply = current_user.posts.new
        @reply.parent = @post
      end

      def create
        @reply = current_user.posts.new(reply_params)
        @reply.parent = @post
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
end
