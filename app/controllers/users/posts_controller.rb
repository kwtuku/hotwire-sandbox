module Users
  class PostsController < Users::ApplicationController
    before_action :set_post, only: %i[edit update destroy]

    def new
      @post = current_user.posts.new
    end

    def edit; end

    def create
      @post = current_user.posts.new(post_params)
      if @post.save
        flash.now.notice = t('general.created', resource_name: Post.model_name.human)
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @post.update(post_params)
        flash.now.notice = t('general.updated', resource_name: Post.model_name.human)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @post.destroy!
      flash.now.notice = t('general.destroyed', resource_name: Post.model_name.human)
    end

    private

    def set_post
      @post = current_user.posts.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:content)
    end
  end
end
