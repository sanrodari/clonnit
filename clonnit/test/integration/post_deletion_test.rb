require 'test_helper'

# As a mu, I want to delete a post from one of my moderated subclonnits
class PostDeletionTest < ActionDispatch::IntegrationTest
  test 'successfully post deletion' do
    # User sign in
    moderator_user = sign_in

    # User creates a subclonnit and becomes the first mod
    test_name        = 'test name'
    test_description = 'test description'
    assert_difference('Subclonnit.count', 1) do
      post '/subclonnits', subclonnit: {
        name:        test_name,
        description: test_description
      }
    end

    subclonnit = assigns[:subclonnit]

    # User sign out
    delete '/users/sign_out'

    # Another user sign in
    another = User.create! username: 'another',
                           email:    'another@example.com',
                           password: '12345678'

    sign_in another

    # Another user creates a post within the created subclonnit
    test_title = 'test title'
    test_url   = 'http://example.com/path'
    test_text  = 'Lorem ipsum dolor sit amet, falli altera ei quo.'

    assert_difference('Post.count', 1) do
      post "/subclonnits/#{subclonnit.id}/posts", post: {
        title: test_title,
        url:   test_url,
        text:  test_text
      }
    end
    post = assigns[:post]

    # Another user sign out
    delete '/users/sign_out'

    # User (mod user) sign in and deletes the post
    sign_in moderator_user

    assert_difference('Post.count', -1) do
      delete "/subclonnits/#{subclonnit.id}/posts/#{post.id}"
    end
    assert_equal I18n.t('posts.successfully_destroyed'),
                 flash[:notice]
  end
end
