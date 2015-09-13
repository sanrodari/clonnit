# == Schema Information
#
# Table name: posts
#
#  id            :integer          not null, primary key
#  title         :string
#  url           :string
#  text          :text
#  user_id       :integer
#  subclonnit_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_posts_on_subclonnit_id  (subclonnit_id)
#  index_posts_on_user_id        (user_id)
#

class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :subclonnit
end
