# Service to create a mod for a subclonnit
class CreateModeratorService
  def initialize(params)
    @user       = params[:user]
    @subclonnit = params[:subclonnit]
    @user_id    = params[:user_id]
  end

  def call
    # Validate if user can add a mod in this subclonnit
    if self.class.can_add?(@user, @subclonnit)
      moderator = Moderator.find_or_create_by! subclonnit: @subclonnit,
                                               user_id:    @user_id

      [:success, moderator]
    else
      [:forbidden, nil]
    end
  rescue => e
    Rails.logger.debug e
    [:error, nil]
  end

  def self.can_add?(user, subclonnit)
    Moderator.exists? user:       user,
                      subclonnit: subclonnit
  end
end
