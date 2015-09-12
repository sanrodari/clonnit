require 'test_helper'

# As a anon, I want to sign in to clonnit so that I can have a user session
class UserSessionTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(
      email:    'test_email@example.com',
      username: 'test_username',
      password: '12345678'
    )
  end

  test 'success sign in' do
    # Access the sign in page
    get '/users/sign_in'
    assert_response :success

    post '/users/sign_in', user: {
      username: @user.username,
      password: @user.password
    }

    # Assert the user is in session
    assert_equal @user.id, @controller.current_user.id

    # Assert flash message
    assert_equal I18n.t('devise.sessions.signed_in'), flash[:notice]
  end

  test 'wrong credentials' do
    post '/users/sign_in', user: {
      username: @user.username,
      password: "wrong-#{@user.password}"
    }

    # Assert the user is not in session
    assert_nil @controller.current_user
  end
end
