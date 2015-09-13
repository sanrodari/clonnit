require 'test_helper'

# As a au, I want to create a subclonnit and become its first mod
# so that I can create and maintain a community
class SubclonnitCreationTest < ActionDispatch::IntegrationTest
  test 'success subclonnit creation' do
    # User needs to be authenticated
    sign_in

    get '/subclonnits/new'
    assert_response :success

    test_name        = 'test name'
    test_description = 'test description'
    post '/subclonnits', subclonnit: {
      name:        test_name,
      description: test_description
    }

    subclonnit = assigns[:subclonnit]

    # Assert flash message
    assert_equal I18n.t('subclonnits.successfully_created'), flash[:notice]

    assert_equal test_name, subclonnit.name
    assert_equal test_description, subclonnit.description

    # The subclonnit created born with the session user as is first mod
    assert Moderator.find_by!(subclonnit: subclonnit, user: session_user)
  end
end
