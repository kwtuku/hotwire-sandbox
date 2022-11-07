module PostsHelper
  def current_user_liked?(post)
    @liked_post_ids ||= current_user.likes.pluck(:post_id)
    @liked_post_ids.include?(post.id) # rubocop:disable Rails/HelperInstanceVariable
  end
end
