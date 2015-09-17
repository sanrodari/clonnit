require 'test_helper'

# As a au, I want to subscribe to a subclonnit
# so that I can customize my frontpage
class SubclonnitSubscriptionTest < ActionDispatch::IntegrationTest
  test 'successfully user subscription' do
    # Subscription for a signed in user
    session_user = sign_in

    # Access the subscriptions page
    get "/users/#{session_user.id}/subscriptions"
    assert_response :success

    # This should be a subset (because of pagination) of the total subscriptions
    subscriptions = assigns[:subscriptions]
    assert session_user.subscriptions
      .map(&:id)
      .to_set
      .subset?(
        subscriptions.map(&:id).to_set
      )

    subclonnit = Subclonnit.create! name:        'Not default',
                                    description: 'Not default subclonnit',
                                    description: false

    post "/users/#{session_user.id}/subscriptions", subscription: {
      subclonnit_id: subclonnit.id
    }

    get "/users/#{session_user.id}/subscriptions"
    assert_response :success

    # The new subscription should be persisted
    assert_includes session_user.subclonnits.reload.map(&:id),
                    subclonnit.id
  end
end
