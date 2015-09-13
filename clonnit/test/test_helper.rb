ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

# Improved Minitest output (color and progress bar)
require 'minitest/reporters'
Minitest::Reporters.use!(
  Minitest::Reporters::ProgressReporter.new,
  ENV,
  Minitest.backtrace_filter)

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  attr_reader :session_user

  def setup
    @session_user = User.create!(
      email:    'test_email@example.com',
      username: 'test_username',
      password: '12345678'
    )
  end

  def sign_in
    post '/users/sign_in', user: {
      username: @session_user.username,
      password: @session_user.password
    }
  end
end
