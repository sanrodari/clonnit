require 'test_helper'

# As a anon, I want to register to clonnit so that I can have an account in it
class UserRegistrationTest < ActionDispatch::IntegrationTest
  def setup
    @test_email    = 'test_email@example.com'
    @test_username = 'test_username'
  end

  test 'success user registration' do
    # Access the registration page
    get '/users/sign_up'
    assert_response :success

    # Create the user
    assert_difference('User.count', 1) do
      post '/users', user: {
        email:                 @test_email,
        username:              @test_username,
        password:              '12345678',
        password_confirmation: '12345678'
      }
    end

    # Assert flash message
    assert_equal flash[:notice], I18n.t('devise.registrations.signed_up')

    # Assert is created with its params
    created_user = User.find_by(username: @test_username)
    assert_equal created_user.email, @test_email
  end

  test 'wrong password confirmation' do
    assert_difference('User.count', 0) do
      post '/users', user: {
        email:                 @test_email,
        username:              @test_username,
        password:              '12345678',
        password_confirmation: '87654321'
      }
    end

    # Assert error message
    user = assigns[:user]
    assert_includes user.errors.messages[:password_confirmation],
                    I18n.t('errors.messages.confirmation', attribute: 'Password')
  end

  test 'require username' do
    assert_difference('User.count', 0) do
      post '/users', user: {
        email:                 @test_email,
        username:              '',
        password:              '12345678',
        password_confirmation: '12345678'
      }
    end

    # Assert error message
    user = assigns[:user]
    assert_includes user.errors.messages[:username],
                    I18n.t('errors.messages.blank')
  end
end