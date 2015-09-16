# Service use for a mod to destroy a post
class GetFrontpagePageService
  def initialize(params)
    @page        = params[:page]
    @subclonnits = params[:subclonnits]
  end

  def call
    # TODO Implement a more sophisticated algorithm
    [:success,
     Post
       .order(:created_at)
       .joins(:subclonnit)
       .where(subclonnits: { id: @subclonnits })
       .includes(:subclonnit) # Includes to avoid n + 1 queries
       .includes(:upvotes)
       .includes(:downvotes)
       .page(@page)]
  end
end
