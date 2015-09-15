require 'test_helper'

# As a mu, I want to assign new mods to a subclonnit
# so that I can share the moderator labors
class AddModeratorTest < ActionDispatch::IntegrationTest
  test 'successfully add moderator to subclonnit' do
    session_user = sign_in

    new_moderator = User.create! username: 'new_moderator',
                                 email:    'new_moderator@example.com',
                                 password: '12345678'

    # Create a subreddit with the session_user as its
    # first moderator
    test_name        = 'test name'
    test_description = 'test description'
    assert_difference('Subclonnit.count', 1) do
      post '/subclonnits', subclonnit: {
        name:        test_name,
        description: test_description
      }
    end
    subclonnit = assigns[:subclonnit]

    # Show me the list of moderators
    get "/subclonnits/#{subclonnit.id}/moderators"
    assert_response :success

    # The session_user should be included in its moderators
    assert_includes assigns[:moderators],
                    Moderator.find_by!(
                      user: session_user, subclonnit: subclonnit)

    # Assert that the current user can add another mod
    assert assigns[:can_add]

    # Show me the form to select the new mod
    get "/subclonnits/#{subclonnit.id}/moderators/new"
    assert_response :success

    # Add the new mod
    assert_difference('Moderator.count', 1) do
      post "/subclonnits/#{subclonnit.id}/moderators", moderator: {
        user_id: new_moderator.id
      }
    end

    # Assert the new moderator has been created
    assert Moderator.exists? subclonnit: subclonnit,
                             user:       new_moderator
  end
end
