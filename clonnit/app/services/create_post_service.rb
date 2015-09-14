# Service to create a post within a subclonnit
class CreatePostService
  def initialize(params)
    @user       = params[:user]
    @subclonnit = params[:subclonnit]
    @title      = params[:title]
    @url        = params[:url]
    @text       = params[:text]
  end

  def call
    post = Post.new user:       @user,
                    subclonnit: @subclonnit,
                    title:      @title,
                    url:        @url,
                    text:       @text

    post.save!
    [:success, post]
  rescue => e
    Rails.logger.debug e
    [:error, post]
  end
end
