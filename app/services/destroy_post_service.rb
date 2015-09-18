# Service use for a mod to destroy a post
class DestroyPostService
  def initialize(params)
    @user = params[:user]
    @post = params[:post]
  end

  def call
    if self.class.can_destroy?(@user, @post)
      @post.destroy!
      [:success, @post]
    else
      [:forbidden, nil]
    end
  rescue => e
    Rails.logger.debug e
    [:error, @post]
  end

  def self.can_destroy?(user, post)
    Moderator.exists? user:       user,
                      subclonnit: post.subclonnit
  end
end
