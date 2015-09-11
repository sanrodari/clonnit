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

    # Assert flash message
    assert_equal flash[:notice], I18n.t('devise.sessions.signed_in')
  end
end
