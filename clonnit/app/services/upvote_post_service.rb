# Service for upvoting a post
class UpvotePostService
  def initialize(params)
    @post = params[:post]
    @user = params[:user]
  end

  def call
    upvote = Upvote.find_or_create_by! user: @user,
                                       post: @post

    [:success, upvote]
  rescue
    [:error, upvote]
  end
end
