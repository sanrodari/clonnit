require 'test_helper'

# As a au, I want to create a post within a subclonnit so that
# I can share my content with others
class PostCreationTest < ActionDispatch::IntegrationTest
  test 'success post creation' do
    # User needs to be authenticated
    session_user = sign_in

    test_name        = 'test name'
    test_description = 'test description'

    subclonnit = Subclonnit.create! name:        test_name,
                                    description: test_description

    # Get the form to create the post
    get "/subclonnits/#{subclonnit.id}/posts/new"
    assert_response :success

    test_title = 'test title'
    test_url   = 'http://example.com/path'
    test_text  =
    'Lorem ipsum dolor sit amet, falli altera ei quo, nec at debitis.' \
    'In mutat aeterno definiebas vel, eum cibo accusam no. Ea qui ferri ' \
    'vivendum. Per ne soluta noster, mundi eripuit per id. Mei persius ' \
    'placerat id. Sea ei erant aperiri virtute, qui no vero graece, at ' \
    'quaeque inermis mei.'

    assert_difference('Post.count', 1) do
      post "/subclonnits/#{subclonnit.id}/posts", post: {
        title: test_title,
        url:   test_url,
        text:  test_text
      }
    end

    post = assigns[:post]

    # Assert flash message
    assert_equal I18n.t('posts.successfully_created'), flash[:notice]

    # Post should has the right attributes
    assert_equal subclonnit.id, post.subclonnit.id
    assert_equal session_user.id, post.user.id
    assert_equal test_title, post.title
    assert_equal test_url, post.url
    assert_equal test_text, post.text
  end
end
