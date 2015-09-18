# Frontpage views helper
module FrontpageHelper
  def calculate_number(posts, index)
    offset = (posts.current_page - 1) * posts.limit_value
    offset + index + 1
  end
end
