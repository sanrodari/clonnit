# Service for toggling downvotes for a post
class ToggleDownvoteService
  def initialize(params)
    @post = params[:post]
    @user = params[:user]
  end

  def call
    result_downvote = nil
    ActiveRecord::Base.transaction do
      downvote = Downvote.find_by user: @user, post: @post

      # Toggle downvote itself
      if downvote
        downvote.destroy!
        result_downvote = nil
      else
        result_downvote = Downvote.create! user: @user, post: @post
      end

      # Delete upvote if exists
      upvote = Upvote.find_by user: @user, post: @post
      upvote.destroy! if upvote
    end
    [:success, result_downvote]
  rescue => e
    Rails.logger.debug e
    [:error, result_downvote]
  end
end
