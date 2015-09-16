require 'test_helper'

# As a eu, I want to visualize the front page
class FrontPageTest < ActionDispatch::IntegrationTest
  test 'success frontpage for anon' do
    default_subclonnits_ids = Subclonnit.default.map(&:id)

    get '/'
    assert_response :success

    posts = assigns[:posts]

    # pozt to avoid collide with post method
    posts.each do |pozt|
      assert_includes default_subclonnits_ids,
                      pozt.subclonnit.id
    end

    # Pagination size
    assert_equal Kaminari.config.default_per_page,
                 posts.size
  end
end
