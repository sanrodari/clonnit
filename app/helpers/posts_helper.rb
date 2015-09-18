# Posts views helper
module PostsHelper
  def upvote_class(current_user, post)
    Upvote.exists?(user: current_user, post: post) ? 'upvoted' : ''
  end

  def downvote_class(current_user, post)
    Downvote.exists?(user: current_user, post: post) ? 'downvoted' : ''
  end
end
