require 'test_helper'

# As a au, I want to upvote/downvote a post so that I can enforce good content
class PostVotingTest < ActionDispatch::IntegrationTest
  test 'upvote a post' do
    session_user = sign_in

    test_name        = 'test name'
    test_description = 'test description'

    subclonnit = Subclonnit.create! name:        test_name,
                                    description: test_description

    test_title = 'test title'
    test_url   = 'http://example.com/path'
    test_text  = 'Lorem ipsum dolor sit amet, falli altera ei quo.'

    post = Post.create! title:      test_title,
                        url:        test_url,
                        text:       test_text,
                        user:       session_user,
                        subclonnit: subclonnit

    assert_difference('Upvote.count', 1) do
      post "/subclonnits/#{subclonnit.id}/posts/#{post.id}/upvote.js"
    end

    assert Upvote.find_by! post: post,
                           user: session_user
  end
end
