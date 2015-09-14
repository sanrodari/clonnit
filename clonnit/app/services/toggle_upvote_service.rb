# Service for toggling upvotes for a post
class ToggleUpvoteService
  def initialize(params)
    @post = params[:post]
    @user = params[:user]
  end

  def call
    result_upvote = nil
    ActiveRecord::Base.transaction do
      upvote = Upvote.find_by user: @user, post: @post

      # Toggle upvote itself
      if upvote
        upvote.destroy!
        result_upvote = nil
      else
        result_upvote = Upvote.create! user: @user, post: @post
      end

      # Delete downvote if exists
      downvote = Downvote.find_by user: @user, post: @post
      downvote.destroy! if downvote
    end
    [:success, result_upvote]
  rescue => e
    Rails.logger.debug e
    [:error, result_upvote]
  end
end
