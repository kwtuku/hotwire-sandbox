module Users
  module Posts
    class LikesController < Users::ApplicationController
      before_action :set_post

      def create
        current_user.likes.create!(post: @post)
      end

      def destroy
        # like = current_user.likes.find_by!(post: @post) だと like.destroy! で @post.likes_count が更新されない
        like = @post.likes.find_by!(user: current_user)
        like.destroy!
      end

      private

      def set_post
        @post = Post.find(params[:post_id])
      end
    end
  end
end
