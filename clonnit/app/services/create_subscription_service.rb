# Service to add a subscription
class CreateSubscriptionService
  def initialize(params)
    @session_user     = params['session_user']
    @subscribing_user = params['subscribing_user']
    @subclonnit_id    = params['subclonnit_id']
  end

  def call
    # Validates is the same user
    if @session_user.id == @subscribing_user.id
      subscription = Subscription.find_or_create_by!(
        user:          @subscribing_user,
        subclonnit_id: @subclonnit_id
      )
      [:success, subscription]
    else
      [:forbidden, nil]
    end
  rescue => e
    Rails.logger.debug e
    [:error, nil]
  end
end
