require 'test_helper'

# As a au, I want to upvote/downvote a post so that I can enforce good content
class PostVotingTest < ActionDispatch::IntegrationTest
  test 'toggle upvote for a post' do
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

    # Show me the post where I can upvote/downvote it
    get "/subclonnits/#{subclonnit.id}/posts/#{post.id}"
    assert_response :success

    assert_difference('Upvote.count', 1) do
      post "/subclonnits/#{subclonnit.id}/posts/#{post.id}/toggle_upvote.js"
    end
    assert Upvote.find_by! post: post, user: session_user

    assert_difference('Upvote.count', -1) do
      post "/subclonnits/#{subclonnit.id}/posts/#{post.id}/toggle_upvote.js"
    end
    assert_nil Upvote.find_by post: post, user: session_user
  end

  test 'toggle downvote for a post' do
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

    assert_difference('Downvote.count', 1) do
      post "/subclonnits/#{subclonnit.id}/posts/#{post.id}/toggle_downvote.js"
    end
    assert Downvote.find_by! post: post, user: session_user

    assert_difference('Downvote.count', -1) do
      post "/subclonnits/#{subclonnit.id}/posts/#{post.id}/toggle_downvote.js"
    end
    assert_nil Downvote.find_by post: post, user: session_user
  end

  test 'upvote should destroy downvote' do
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

    assert_difference('Downvote.count', 1) do
      post "/subclonnits/#{subclonnit.id}/posts/#{post.id}/toggle_downvote.js"
    end
    assert Downvote.find_by! post: post, user: session_user

    assert_difference('Downvote.count', -1) do
      post "/subclonnits/#{subclonnit.id}/posts/#{post.id}/toggle_upvote.js"
    end
    assert Upvote.find_by! post: post, user: session_user
  end

  test 'downvote should destroy upvote' do
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
      post "/subclonnits/#{subclonnit.id}/posts/#{post.id}/toggle_upvote.js"
    end
    assert Upvote.find_by! post: post, user: session_user

    assert_difference('Upvote.count', -1) do
      post "/subclonnits/#{subclonnit.id}/posts/#{post.id}/toggle_downvote.js"
    end
    assert Downvote.find_by! post: post, user: session_user
  end
end
