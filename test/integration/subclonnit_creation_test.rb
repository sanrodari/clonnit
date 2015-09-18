require 'test_helper'

# As a au, I want to create a subclonnit and become its first mod
# so that I can create and maintain a community
class SubclonnitCreationTest < ActionDispatch::IntegrationTest
  test 'success subclonnit creation' do
    # User needs to be authenticated
    session_user = sign_in

    # Get the form to create the subclonnit
    get '/subclonnits/new'
    assert_response :success

    test_name        = 'test name'
    test_description = 'test description'
    assert_difference('Subclonnit.count', 1) do
      post '/subclonnits', subclonnit: {
        name:        test_name,
        description: test_description
      }
    end

    subclonnit = assigns[:subclonnit]

    # Assert flash message
    assert_equal I18n.t('subclonnits.successfully_created'), flash[:notice]

    assert_equal test_name, subclonnit.name
    assert_equal test_description, subclonnit.description

    # The subclonnit created born with the session user as is first mod
    assert Moderator.find_by!(subclonnit: subclonnit, user: session_user)
  end

  test 'subclonnit needs unique name' do
    # User needs to be authenticated
    sign_in

    test_name        = 'test name'
    test_description = 'test description'
    2.times do |i|
      post '/subclonnits', subclonnit: {
        # Case insensitive uniqueness
        name:        i == 0 ? test_name : test_name.upcase,
        description: test_description
      }
    end

    # Assert error message
    subclonnit = assigns[:subclonnit]
    assert_includes subclonnit.errors.messages[:name],
                    I18n.t('errors.messages.taken')
  end

  test 'subclonnit needs a name' do
    # User needs to be authenticated
    sign_in

    test_name        = ''
    test_description = 'test description'
    post '/subclonnits', subclonnit: {
      # Case insensitive uniqueness
      name:        test_name,
      description: test_description
    }

    # Assert error message
    subclonnit = assigns[:subclonnit]
    assert_includes subclonnit.errors.messages[:name],
                    I18n.t('errors.messages.blank')
  end
end
