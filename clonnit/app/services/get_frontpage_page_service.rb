# Service use for a mod to destroy a post
class GetFrontpagePageService
  def initialize(params)
    @page        = params[:page]
    @user        = params[:user]

    # For anon default, for an authenticated its subclonnits
    @subclonnits = @user.nil? ? Subclonnit.default : @user.subclonnits
  end

  def call
    # TODO Implement a more sophisticated algorithm
    [:success,
     Post
       .order(created_at: :desc)
       .joins(:subclonnit)
       .where(subclonnits: { id: @subclonnits })
       .includes(:subclonnit) # Includes to avoid n + 1 queries
       .includes(:upvotes)
       .includes(:downvotes)
       .page(@page)]
  end
end
