require 'test_helper'

# As a anon, I want to register to clonnit so that I can have an account in it
class UserRegistrationTest < ActionDispatch::IntegrationTest
  test 'success user registration' do
    # Access the registration page
    get '/users/sign_up'
    assert_response :success

    test_email    = 'test_email@example.com'
    test_username = 'test_username'

    # Create the user
    assert_difference('User.count', 1) do
      post '/users', user: {
        email:                 test_email,
        username:              test_username,
        password:              '12345678',
        password_confirmation: '12345678'
      }
    end

    # Assert is created with its params
    created_user = User.find_by(username: test_username)
    assert_equal created_user.email, test_email
  end
end
