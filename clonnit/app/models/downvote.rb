# == Schema Information
#
# Table name: downvotes
#
#  id         :integer          not null, primary key
#  post_id    :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_downvotes_on_post_id  (post_id)
#  index_downvotes_on_user_id  (user_id)
#

class Downvote < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
end
