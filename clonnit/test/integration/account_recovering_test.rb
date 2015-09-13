require 'test_helper'

# As a anon, I want to be able to recover my account giving my username
class AccountRecoveringTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(
      email:    'test_email@example.com',
      username: 'test_username',
      password: '12345678'
    )
  end

  test 'success recovering' do
    # Access the recovering page
    get '/users/password/new'
    assert_response :success

    post '/users/password', user: {
      username: @user.username
    }

    recover_email = ActionMailer::Base.deliveries.last

    # Asserts for the sent mail
    assert_equal I18n.t('devise.mailer.reset_password_instructions.subject'),
                 recover_email.subject
    assert_equal @user.email, recover_email.to[0]
    body = Nokogiri::HTML(recover_email.body.to_s)
    recover_link = body.at('a#change_pasword_link')['href']

    refute_empty recover_link

    # Access the recovering link
    get recover_link
    assert_response :success

    token = recover_link.match('reset_password_token=(.*?[^&]+)').captures[0]

    new_password = '87654321'
    put '/users/password', user: {
      reset_password_token:  token,
      password:              new_password,
      password_confirmation: new_password
    }

    # Assert password is changed
    assert User.find(@user.id).valid_password? new_password
  end
end
